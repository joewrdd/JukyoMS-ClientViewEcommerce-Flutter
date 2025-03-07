import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/rounded_container.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/shop/controllers/checkout_controller.dart';
import 'package:jukyo_ms/views/shop/models/payment_method_model.dart';

class CustomPaymentTile extends StatelessWidget {
  const CustomPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    final dark = HelperFunctions.isDarkMode(context);
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: CustomRoundedContainer(
        width: (paymentMethod.image == ConstantImages.cashOnDelivery) ? 60 : 60,
        height:
            (paymentMethod.image == ConstantImages.cashOnDelivery) ? 50 : 40,
        backgroundColor: dark ? ConstantColors.light : ConstantColors.white,
        padding: const EdgeInsets.all(ConstantSizes.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
