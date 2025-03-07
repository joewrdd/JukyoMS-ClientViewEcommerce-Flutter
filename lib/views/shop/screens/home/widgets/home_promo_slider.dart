import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/custom/images/rounded_image.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/circular_container.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/utils/shimmers/shimmer.dart';
import 'package:jukyo_ms/views/shop/controllers/banner_controller.dart';

class HomePromoSlider extends StatelessWidget {
  const HomePromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    final dark = HelperFunctions.isDarkMode(context);
    return Obx(
      () {
        // Loader
        if (controller.isLoading.value) {
          return const TShimmerEffect(width: double.infinity, height: 190);
        }

        // No Data
        if (controller.banners.isEmpty) {
          return Center(
            child: Text(
              'No Data Found',
              style: TextStyle(
                  color: dark
                      ? ConstantColors.borderSecondary
                      : ConstantColors.black),
            ),
          );
        } else {
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, reason) =>
                      controller.updatePageIndicator(index),
                ),
                items: controller.banners
                    .map((banner) => CustomRoundedImage(
                          imageUrl: banner.imageUrl,
                          isNetworkImage: true,
                          onTap: () => Get.toNamed(banner.targetScreen),
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              Center(
                child: Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < controller.banners.length; i++)
                        CustomCircularContainer(
                          width: 20,
                          height: 4,
                          margin: EdgeInsets.only(
                            right: 10,
                          ),
                          backgroundColor:
                              controller.carousalCurrentIndex.value == i
                                  ? ConstantColors.primary
                                  : ConstantColors.grey,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
