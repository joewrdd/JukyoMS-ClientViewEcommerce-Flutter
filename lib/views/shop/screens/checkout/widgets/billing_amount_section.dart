import 'package:flutter/material.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/pricing_calculator.dart';
import 'package:jukyo_ms/views/shop/controllers/products/cart_controller.dart';

class CustomBillingAmountSection extends StatelessWidget {
  const CustomBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return FutureBuilder<Map<String, String>>(
      future: PricingCalculator.calculatePriceBreakdown(subTotal, 'US'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: ConstantColors.primary,
          );
        }

        final prices = snapshot.data ??
            {'tax': '0.00', 'shipping': '0.00', 'total': '0.00'};

        return Column(
          children: [
            // SubTotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
                Text('\$$subTotal',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
            // Shipping Fee
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping Fee',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text('\$${prices['shipping']}',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
            // Tax Fee
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
                Text('\$${prices['tax']}',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
            // Order Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Total',
                    style: Theme.of(context).textTheme.titleMedium),
                Text('\$${prices['total']}',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ],
        );
      },
    );
  }
}
