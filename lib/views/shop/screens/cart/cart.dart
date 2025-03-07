import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/navigation.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/loaders/animation.dart';
import 'package:jukyo_ms/views/shop/controllers/products/cart_controller.dart';
import 'package:jukyo_ms/views/shop/screens/cart/widgets/full_cart_items.dart';
import 'package:jukyo_ms/views/shop/screens/checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      // Bottom Bar Button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(ConstantSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(
                  () => const CheckoutScreen(),
                ),
                child: controller.cartItems.isEmpty
                    ? const SizedBox()
                    : Obx(
                        () => Text(
                          'Checkout \$${controller.totalCartPrice.value}',
                        ),
                      ),
              ),
            ),
      body: Obx(
        () {
          final emptyWidget = AnimationLoaderWidget(
            text: 'Whoops! Cart Is EMPTY.',
            animation: ConstantImages.emptyCart,
            animationType: AnimationType.gif,
            showAction: true,
            actionText: 'Head To Store & Add Some!',
            onActionPressed: () => Get.off(
              () => const NavigationMenu(),
            ),
          );
          return controller.cartItems.isEmpty
              ? emptyWidget
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      ConstantSizes.defaultSpace,
                    ),
                    // Items In Cart
                    child: FullCartItems(),
                  ),
                );
        },
      ),
    );
  }
}
