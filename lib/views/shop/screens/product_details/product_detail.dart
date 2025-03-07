import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/appbar/bottom_navbar.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/routes/routes.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/enums/product_type.dart';
import 'package:jukyo_ms/views/shop/controllers/products/variation_controller.dart';
import 'package:jukyo_ms/views/shop/controllers/review_controller.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';
import 'package:jukyo_ms/views/shop/screens/product_details/widgets/product_detail_attributes.dart';
import 'package:jukyo_ms/views/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:jukyo_ms/views/shop/screens/product_details/widgets/product_detail_metadata.dart';
import 'package:jukyo_ms/views/shop/screens/product_details/widgets/product_detail_rating_and_share.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final variationController = Get.put(VariationController());
    final reviewController = Get.put(ReviewController());

    // Reset Variations When Product Changes
    if (variationController.currentProduct.value?.id != product.id) {
      variationController.resetSelectedAttributes();
      variationController.currentProduct.value = product;
    }

    // Load Product Reviews After The Build Phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reviewController.loadProductReviews(product.id);
    });

    return Scaffold(
      bottomNavigationBar: CustomButtonAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1 - Product Image Slider
            CustomProductImageSlider(
              product: product,
            ),
            // 2- Product Details
            Padding(
              padding: EdgeInsets.only(
                right: ConstantSizes.defaultSpace,
                left: ConstantSizes.defaultSpace,
                bottom: ConstantSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  // Rating and Share Button
                  CustomProductRatingAndShare(),
                  // Price, Title, Stock, & Brand
                  CustomProductMetaData(
                    product: product,
                  ),
                  // Attributes
                  if (product.productType == ProductType.variable.toString())
                    CustomProductAttributes(
                      product: product,
                    ),
                  const SizedBox(
                    height: ConstantSizes.spaceBtwItems / 2,
                  ),
                  // Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: ConstantSizes.md - 4,
                          horizontal: ConstantSizes.lg,
                        ),
                        backgroundColor: ConstantColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ConstantSizes.buttonRadius),
                        ),
                      ),
                      child: Text(
                        'Checkout',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: ConstantSizes.spaceBtwSections / 2,
                  ),
                  // Description
                  const CustomSectionHeader(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: ConstantSizes.spaceBtwItems / 2,
                  ),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      color: ConstantColors.buttonPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  // Reviews
                  Divider(),
                  const SizedBox(
                    height: ConstantSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => CustomSectionHeader(
                            title:
                                'Reviews (${reviewController.productStats.value['total'] ?? 0})',
                            showActionButton: false,
                          )),
                      IconButton(
                        onPressed: () => Get.toNamed(
                          CustomRoutes.productReviews,
                          arguments: product.id,
                        ),
                        icon: const Icon(
                          Iconsax.arrow_right_14,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: ConstantSizes.spaceBtwSections,
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
