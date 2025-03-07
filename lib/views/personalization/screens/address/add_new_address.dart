import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/validators/validation.dart';
import 'package:jukyo_ms/views/personalization/controllers/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Add New Address',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            ConstantSizes.defaultSpace,
          ),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      Validator.validateEmptyText('Name', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.user,
                    ),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: ConstantSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => Validator.validatePhoneNumber(value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.mobile,
                    ),
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(
                  height: ConstantSizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) =>
                            Validator.validateEmptyText('Street', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Iconsax.building_3,
                          ),
                          labelText: 'Street',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: ConstantSizes.spaceBtwInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) =>
                            Validator.validateEmptyText('Postal Code', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Iconsax.code,
                          ),
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: ConstantSizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) =>
                            Validator.validateEmptyText('City', value),
                        expands: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Iconsax.building,
                          ),
                          labelText: 'City',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: ConstantSizes.spaceBtwInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) =>
                            Validator.validateEmptyText('State', value),
                        expands: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Iconsax.activity,
                          ),
                          labelText: 'State',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: ConstantSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: controller.country,
                  validator: (value) =>
                      Validator.validateEmptyText('Country', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.global,
                    ),
                    labelText: 'Country',
                  ),
                ),
                const SizedBox(
                  height: ConstantSizes.defaultSpace,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addNewAddress(),
                    child: Text(
                      'Save',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
