import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/data/repos/address/address_repository.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/cloud.dart';
import 'package:jukyo_ms/utils/helpers/network_manager.dart';
import 'package:jukyo_ms/utils/popups/fullscreen_loader.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/personalization/models/address_model.dart';
import 'package:jukyo_ms/views/personalization/screens/address/add_new_address.dart';
import 'package:jukyo_ms/views/personalization/screens/address/widgets/single_address.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  //----- Fetch All User Specific Addresses -----
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Address Not Found!', message: e.toString());
      return [];
    }
  }

  //----- Selected Address -----
  Future selectAddress(AddressModel onSelectedAddress) async {
    try {
      // Clear The 'selected' Field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }
      // Assign Selected Address
      onSelectedAddress.selectedAddress = true;
      selectedAddress.value = onSelectedAddress;

      // Set The 'selected' Field to True For The Newly Selected Address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      Loaders.errorSnackBar(
          title: 'Error Selecting Address', message: e.toString());
    }
  }

  //----- Add New Address -----
  Future addNewAddress() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Address...', ConstantImages.addingNewAddress);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Address Data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        country: country.text.trim(),
        postalCode: postalCode.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);

      // Update Selected Address Status
      address.id = id;
      await selectAddress(address);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(
          title: 'Success',
          message: 'Your address has been saved successfully.');

      // Refresh Address Data
      refreshData.toggle();

      // Reset Fields
      resetFormFields();

      // ReDirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Address Not Found', message: e.toString());
    }
  }

  //----- Show Addresses Bottom Sheet At Checkout -----
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(ConstantSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSectionHeader(
              title: 'Select Address',
              showActionButton: false,
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwItems,
            ),
            FutureBuilder(
              future: getAllUserAddresses(),
              builder: (_, snapshot) {
                // Helper Function To Handle Loader, No Record, Error Messages
                final response = CloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => CustomSingleAddress(
                    address: snapshot.data![index],
                    onTap: () async {
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: ConstantSizes.defaultSpace * 2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const AddNewAddressScreen()),
                child: const Text(
                  'Add New Address',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //----- Function To Reset Form Fields -----
  resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
