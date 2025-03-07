import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/views/shop/controllers/products/cart_controller.dart';
import 'package:jukyo_ms/views/shop/screens/cart/cart.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
    required this.iconColor,
    required this.textColor,
    required this.containerColor,
  });

  final Color iconColor;
  final Color textColor;
  final Color containerColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => CartScreen()),
          icon: Image.asset(
            ConstantImages.cartIcon,
            width: 24,
            height: 24,
            color: iconColor,
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.noOfCartItems.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: textColor, fontSizeFactor: 0.8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
