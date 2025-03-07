import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/custom/images/rounded_image.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/rounded_container.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/brand_title_text_with_verified.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/product_price_text.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/product_title_text.dart';
import 'package:jukyo_ms/common/widgets/products/favorite_icon.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/enums/product_type.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/shop/controllers/products/cart_controller.dart';
import 'package:jukyo_ms/views/shop/controllers/products/product_controller.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';
import 'package:jukyo_ms/views/shop/screens/product_details/product_detail.dart';

class CustomProductCardHorizontal extends StatelessWidget {
  const CustomProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final cartController = CartController.instance;

    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetailScreen(
          product: product,
        ),
      ),
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ConstantSizes.productImageRadius),
          color: dark ? ConstantColors.darkerGrey : ConstantColors.softGrey,
        ),
        child: Row(
          children: [
            // Thumbnail
            CustomRoundedContainer(
              height: 150,
              padding: const EdgeInsets.all(ConstantSizes.md),
              backgroundColor:
                  dark ? ConstantColors.dark : ConstantColors.light,
              child: Stack(
                children: [
                  // Thumbnail Image
                  SizedBox(
                    height: 150,
                    width: 135,
                    child: CustomRoundedImage(
                      imageUrl: product.thumbnail,
                      isNetworkImage: true,
                      applyImageRadius: true,
                    ),
                  ),
                  // Sale Tag
                  Positioned(
                    top: 5,
                    child: CustomRoundedContainer(
                      radius: ConstantSizes.sm,
                      backgroundColor: (product.salePrice > 0)
                          ? ConstantColors.secondary.withOpacity(0.8)
                          : Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: ConstantSizes.sm,
                          vertical: ConstantSizes.xs),
                      child: (product.salePrice > 0)
                          ? Text(
                              '${salePercentage ?? 0}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .apply(color: ConstantColors.black),
                            )
                          : Text(''),
                    ),
                  ),
                  // Wishlist Button
                  Positioned(
                    top: -8,
                    right: -9,
                    child: CustomFavoriteIcon(
                      productId: product.id,
                    ),
                  ),
                ],
              ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(ConstantSizes.sm),
                child: SizedBox(
                  height: 118,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomProductTitleText(
                            title: product.title,
                            smallSize: true,
                          ),
                          const SizedBox(
                            height: ConstantSizes.spaceBtwItems / 2,
                          ),
                          CustomBrandTitleWithVerifiedIcon(
                            title: product.brand!.name,
                          )
                        ],
                      ),
                      const Spacer(),
                      // Pricing
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Pricing
                          Flexible(
                            child: Column(
                              children: [
                                // Sale Price
                                if (product.productType ==
                                        '${ProductType.single}' &&
                                    product.salePrice > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: ConstantSizes.sm),
                                    child: Text(
                                      product.price.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .apply(
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                    ),
                                  ),
                                // Main Price
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: ConstantSizes.sm),
                                  child: CustomProductPriceText(
                                      price:
                                          controller.getProductPrice(product)),
                                ),
                              ],
                            ),
                          ),
                          // Add to Cart button
                          GestureDetector(
                            onTap: () {
                              // If The Product Has A Variation, Show The Variation Dialog
                              if (product.productType ==
                                  ProductType.single.toString()) {
                                final cartItem = cartController
                                    .convertToCartItem(product, 1);
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
                                final productQuantityInCart = cartController
                                    .getProductQuantityInCart(product.id);
                                return Container(
                                  decoration: BoxDecoration(
                                    color: productQuantityInCart > 0
                                        ? const Color.fromARGB(255, 46, 60, 70)
                                        : ConstantColors.dark,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          ConstantSizes.cardRadiusMd),
                                      bottomRight: Radius.circular(
                                          ConstantSizes.productImageRadius),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: ConstantSizes.iconLg * 1.4,
                                    height: ConstantSizes.iconLg * 1.4,
                                    child: Center(
                                      child: productQuantityInCart > 0
                                          ? Text(
                                              productQuantityInCart.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .apply(
                                                    color: Colors.white,
                                                  ),
                                            )
                                          : Icon(
                                              Iconsax.add,
                                              color: ConstantColors.white,
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
