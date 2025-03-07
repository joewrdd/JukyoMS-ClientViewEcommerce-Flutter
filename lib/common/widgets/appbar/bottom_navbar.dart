import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/custom/icons/circular_icon.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/shop/controllers/products/cart_controller.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class CustomButtonAddToCart extends StatelessWidget {
  const CustomButtonAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    cartController.updateAlreadyAddedProductCount(product);
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ConstantSizes.defaultSpace,
          vertical: ConstantSizes.defaultSpace / 1.5),
      decoration: BoxDecoration(
        color: dark ? ConstantColors.darkerGrey : ConstantColors.fourth,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            ConstantSizes.cardRadiusLg,
          ),
          topRight: Radius.circular(
            ConstantSizes.cardRadiusLg,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: dark
                ? const Color.fromARGB(255, 188, 227, 234).withOpacity(0.2)
                : const Color.fromARGB(255, 54, 77, 93).withOpacity(0.2),
            blurRadius: 18,
            offset: const Offset(0, -5),
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: ConstantColors.fourth,
                  width: 40,
                  height: 40,
                  color: ConstantColors.primary,
                  onPressed: () =>
                      cartController.productQuantityInCart.value < 1
                          ? null
                          : cartController.productQuantityInCart.value -= 1,
                ),
                const SizedBox(
                  width: ConstantSizes.spaceBtwItems,
                ),
                Text(
                  (cartController.productQuantityInCart.value).toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  width: ConstantSizes.spaceBtwItems,
                ),
                CustomCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: ConstantColors.primary,
                  width: 40,
                  height: 40,
                  color: ConstantColors.white,
                  onPressed: () =>
                      cartController.productQuantityInCart.value += 1,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: cartController.productQuantityInCart.value < 1
                  ? null
                  : () => cartController.addToCart(product),
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: ConstantColors.primary,
                padding: const EdgeInsets.all(
                  ConstantSizes.sm + 5,
                ),
                backgroundColor: ConstantColors.primary,
                side: const BorderSide(
                  color: ConstantColors.primary,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'ADD TO CART',
                    style: GoogleFonts.barlow(color: Colors.white),
                  ),
                  const SizedBox(
                    width: ConstantSizes.spaceBtwItems / 1.5,
                  ),
                  Icon(
                    Iconsax.send_1,
                    color: ConstantColors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
