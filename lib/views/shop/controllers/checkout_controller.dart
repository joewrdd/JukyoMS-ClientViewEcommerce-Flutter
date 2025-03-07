import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/views/shop/models/payment_method_model.dart';
import 'package:jukyo_ms/views/shop/screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(image: ConstantImages.visa, name: 'Visa');
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(ConstantSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSectionHeader(
                title: 'Select Payment Method',
                showActionButton: false,
              ),
              SizedBox(
                height: ConstantSizes.spaceBtwSections,
              ),
              CustomPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: ConstantImages.cashOnDelivery,
                  name: 'Cash On Delivery',
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems / 2,
              ),
              CustomPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: ConstantImages.visa,
                  name: 'Visa',
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems / 2,
              ),
              CustomPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: ConstantImages.paypal,
                  name: 'Paypal',
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems / 2,
              ),
              CustomPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: ConstantImages.googlePay,
                  name: 'Google Pay',
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems / 2,
              ),
              CustomPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: ConstantImages.applePay,
                  name: 'Apple Pay',
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems / 2,
              ),
              CustomPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: ConstantImages.masterCard,
                  name: 'Master Card',
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems / 2,
              ),
              CustomPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: ConstantImages.paytm,
                  name: 'Paytm',
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems / 2,
              ),
              CustomPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: ConstantImages.paystack,
                  name: 'Paystack',
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems / 2,
              ),
              CustomPaymentTile(
                paymentMethod: PaymentMethodModel(
                  image: ConstantImages.creditCard,
                  name: 'Credit Card',
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
