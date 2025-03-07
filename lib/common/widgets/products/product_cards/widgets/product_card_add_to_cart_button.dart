import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/enums/product_type.dart';
import 'package:jukyo_ms/views/shop/controllers/products/cart_controller.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';
import 'package:jukyo_ms/views/shop/screens/product_details/product_detail.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return GestureDetector(
      onTap: () {
        // If The Product Has A Variation, Show The Variation Dialog
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneItemToCart(cartItem);
        } else {
          // Else, Add The Product To The Cart
          Get.to(
            () => ProductDetailScreen(product: product),
          );
        }
      },
      child: Obx(
        () {
          final productQuantityInCart =
              cartController.getProductQuantityInCart(product.id);
          return Container(
            decoration: BoxDecoration(
              color: productQuantityInCart > 0
                  ? const Color.fromARGB(255, 46, 60, 70)
                  : ConstantColors.dark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ConstantSizes.cardRadiusMd),
                bottomRight: Radius.circular(ConstantSizes.productImageRadius),
              ),
            ),
            child: SizedBox(
              width: ConstantSizes.iconLg * 1.2,
              height: ConstantSizes.iconLg * 1.2,
              child: Center(
                child: productQuantityInCart > 0
                    ? Text(
                        productQuantityInCart.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: Colors.white,
                            ),
                      )
                    : const Icon(
                        Iconsax.add,
                        color: ConstantColors.white,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
