import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/custom/images/rounded_image.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/curved_edges_widget.dart';
import 'package:jukyo_ms/common/widgets/products/favorite_icon.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/shop/controllers/products/image_controller.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class CustomProductImageSlider extends StatelessWidget {
  const CustomProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    return CustomCurvedEdgesWidget(
      child: Container(
        color: dark ? ConstantColors.darkerGrey : ConstantColors.light,
        child: Stack(
          children: [
            // App Bar Icons
            CustomAppBar(
              showBackArrow: true,
              actions: [
                CustomFavoriteIcon(
                  productId: product.id,
                ),
              ],
            ),
            // Main Large Images
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(
                  ConstantSizes.productImageRadius * 2,
                ),
                child: Center(
                  child: Obx(
                    () {
                      final image = controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder:
                              (context, url, progressDownload) =>
                                  CircularProgressIndicator(
                            value: progressDownload.progress,
                            color: ConstantColors.primary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: ConstantSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(
                    width: ConstantSizes.spaceBtwItems,
                  ),
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) => Obx(
                    () {
                      final selectedImage =
                          controller.selectedProductImage.value ==
                              images[index];
                      return CustomRoundedImage(
                        width: 80,
                        isNetworkImage: true,
                        padding: const EdgeInsets.all(ConstantSizes.sm),
                        imageUrl: images[index],
                        onTap: () => controller.selectedProductImage.value =
                            images[index],
                        backgroundColor:
                            dark ? ConstantColors.dark : ConstantColors.white,
                        border: Border.all(
                            color: selectedImage
                                ? ConstantColors.primary
                                : Colors.transparent),
                      );
                    },
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
