import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/rounded_container.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/shop/controllers/checkout_controller.dart';

class CustomBillingPaymentSection extends StatelessWidget {
  const CustomBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController = Get.put(CheckoutController());
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      children: [
        CustomSectionHeader(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => checkoutController.selectPaymentMethod(context),
        ),
        const SizedBox(
          height: ConstantSizes.spaceBtwItems / 2,
        ),
        Obx(
          () => Row(
            children: [
              CustomRoundedContainer(
                width: 60,
                height: (checkoutController.selectedPaymentMethod.value.image ==
                        ConstantImages.cashOnDelivery)
                    ? 45
                    : 35,
                backgroundColor:
                    dark ? ConstantColors.light : ConstantColors.white,
                padding: const EdgeInsets.all(
                  ConstantSizes.sm,
                ),
                child: Image(
                  image: AssetImage(
                    checkoutController.selectedPaymentMethod.value.image,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems / 2,
              ),
              Text(
                checkoutController.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
