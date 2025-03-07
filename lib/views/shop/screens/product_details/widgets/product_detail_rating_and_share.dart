import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/views/shop/controllers/review_controller.dart';

class CustomProductRatingAndShare extends StatelessWidget {
  const CustomProductRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Rating
        Obx(() => Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: ConstantSizes.sm, vertical: ConstantSizes.xs),
              decoration: BoxDecoration(
                color: ConstantColors.primary,
                borderRadius:
                    BorderRadius.circular(ConstantSizes.borderRadiusMd),
              ),
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: ConstantSizes.xs / 3),
                    child: Icon(
                      Iconsax.star1,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: controller.productStats.value['average']
                                  ?.toStringAsFixed(1) ??
                              '0.0',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.white),
                        ),
                        TextSpan(
                          text:
                              ' (${controller.productStats.value['total'] ?? 0})',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        // Share Button
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
            size: ConstantSizes.iconMd,
          ),
        ),
      ],
    );
  }
}
