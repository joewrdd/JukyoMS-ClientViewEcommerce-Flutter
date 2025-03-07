import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/cloud.dart';
import 'package:jukyo_ms/views/personalization/controllers/address_controller.dart';
import 'package:jukyo_ms/views/personalization/screens/address/add_new_address.dart';
import 'package:jukyo_ms/views/personalization/screens/address/widgets/single_address.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
          () => const AddNewAddressScreen(),
        ),
        backgroundColor: ConstantColors.buttonPrimary,
        child: const Icon(
          Iconsax.add,
          color: ConstantColors.white,
        ),
      ),
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ConstantSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              // Use Key To Trigger Refresh
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot) {
                // Helper Function To Handle Loader, Problems, Errors
                final respone = CloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (respone != null) return respone;

                final addresses = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (context, index) => CustomSingleAddress(
                    address: addresses[index],
                    onTap: () => controller.selectAddress(
                      addresses[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
