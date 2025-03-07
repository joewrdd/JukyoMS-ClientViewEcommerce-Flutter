import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/styles/shadows.dart';
import 'package:jukyo_ms/common/widgets/custom/images/rounded_image.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/brand_title_text_with_verified.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/product_price_text.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/product_title_text.dart';
import 'package:jukyo_ms/common/widgets/products/favorite_icon.dart';
import 'package:jukyo_ms/common/widgets/products/product_cards/widgets/product_card_add_to_cart_button.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/enums/product_type.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/shop/controllers/products/product_controller.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';
import 'package:jukyo_ms/views/shop/screens/product_details/product_detail.dart';

class CustomProductCardVertical extends StatelessWidget {
  const CustomProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final dark = HelperFunctions.isDarkMode(context);
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetailScreen(
          product: product,
        ),
      ),
      child: Container(
        width: 180,
        height: 290,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [CustomShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(ConstantSizes.productImageRadius),
          color: dark ? ConstantColors.darkerGrey : ConstantColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail, Discount Tag, and Wishlist Button
            Container(
              height: 160,
              padding: const EdgeInsets.all(ConstantSizes.sm),
              decoration: BoxDecoration(
                color: dark ? ConstantColors.dark : ConstantColors.light,
                borderRadius: BorderRadius.circular(ConstantSizes.cardRadiusLg),
              ),
              child: Stack(
                children: [
                  // Thumbnail Image
                  Positioned.fill(
                    child: CustomRoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),
                  // Discount Tag
                  Positioned(
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: ConstantSizes.sm,
                        vertical: ConstantSizes.xs,
                      ),
                      decoration: BoxDecoration(
                        color: (product.salePrice > 0)
                            ? ConstantColors.secondary.withOpacity(0.8)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(ConstantSizes.sm),
                      ),
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
                    top: 0,
                    right: 0,
                    child: CustomFavoriteIcon(
                      productId: product.id,
                    ),
                  ),
                ],
              ),
            ),

            // Product Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(ConstantSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    CustomProductTitleText(
                      title: product.title,
                      smallSize: true,
                      maxLines: 1,
                    ),
                    const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                    // Brand
                    CustomBrandTitleWithVerifiedIcon(
                      title: product.brand?.name ?? 'Unknown Brand',
                    ),
                    const Spacer(),
                    // Price and Add to Cart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
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
                                    price: controller.getProductPrice(product)),
                              ),
                            ],
                          ),
                        ),

                        // Add To Cart Button
                        ProductCardAddToCartButton(
                          product: product,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
