import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/views/personalization/controllers/address_controller.dart';

class CustomBillingAddressSection extends StatelessWidget {
  const CustomBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSectionHeader(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),
        Obx(
          () => addressController.selectedAddress.value.id.isNotEmpty
              ? Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Iconsax.tag_user,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: ConstantSizes.spaceBtwItems),
                        Text(
                          addressController.selectedAddress.value.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: ConstantSizes.spaceBtwItems),
                        Text(
                          addressController.selectedAddress.value.phoneNumber,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.location4,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: ConstantSizes.spaceBtwItems),
                        Expanded(
                          child: Text(
                            "${addressController.selectedAddress.value.street}, ${addressController.selectedAddress.value.city}, ${addressController.selectedAddress.value.state}, ${addressController.selectedAddress.value.country}",
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                  ],
                )
              : Center(
                  heightFactor: 1.25,
                  child: Container(
                    padding: const EdgeInsets.all(ConstantSizes.md),
                    child: Column(
                      children: [
                        const Icon(
                          Iconsax.house,
                          size: 32,
                          color: ConstantColors.primary,
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                        Text(
                          'No Address Selected',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwItems / 4),
                        Text(
                          'Please select a delivery address',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
