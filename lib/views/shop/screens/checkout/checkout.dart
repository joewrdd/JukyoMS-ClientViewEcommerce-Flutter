import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/rounded_container.dart';
import 'package:jukyo_ms/common/widgets/products/cart/coupon_code_widget.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/utils/helpers/pricing_calculator.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/shop/controllers/order_controller.dart';
import 'package:jukyo_ms/views/shop/controllers/products/cart_controller.dart';
import 'package:jukyo_ms/views/shop/screens/cart/widgets/full_cart_items.dart';
import 'package:jukyo_ms/views/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:jukyo_ms/views/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:jukyo_ms/views/shop/screens/checkout/widgets/billing_payment_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount =
        PricingCalculator.calculatePriceBreakdown(subTotal, 'US');
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      // Bottom Bar Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(ConstantSizes.defaultSpace),
        child: FutureBuilder<Map<String, String>>(
          future: totalAmount,
          builder: (context, snapshot) {
            return ElevatedButton(
              onPressed: subTotal > 0
                  ? () async {
                      final prices = await totalAmount;
                      orderController.processOrder(
                          double.parse(prices['total'] ?? '0.00'));
                    }
                  : () => Loaders.warningSnackBar(
                      title: 'Empty Cart',
                      message: 'Add item in cart in order to proceed.'),
              child: Text(
                  'Confirm Payment \$${snapshot.data?['total'] ?? '0.00'}'),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            ConstantSizes.defaultSpace,
          ),
          child: Column(
            children: [
              // Items in Cart
              const FullCartItems(
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwSections,
              ),

              // Coupon TextField
              CustomCouponCode(),
              const SizedBox(
                height: ConstantSizes.spaceBtwSections,
              ),

              // Billing Section
              CustomRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(ConstantSizes.md),
                backgroundColor:
                    dark ? ConstantColors.black : ConstantColors.white,
                child: Column(
                  children: [
                    // Pricing
                    CustomBillingAmountSection(),
                    const SizedBox(
                      height: ConstantSizes.spaceBtwItems,
                    ),
                    // Divider
                    const Divider(),
                    const SizedBox(
                      height: ConstantSizes.spaceBtwItems,
                    ),
                    // Payment Methods
                    CustomBillingPaymentSection(),
                    const SizedBox(
                      height: ConstantSizes.spaceBtwItems,
                    ),
                    // Address
                    CustomBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
