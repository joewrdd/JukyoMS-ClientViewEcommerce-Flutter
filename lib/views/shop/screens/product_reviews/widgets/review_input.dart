import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/views/shop/controllers/review_controller.dart';

class ReviewInput extends StatelessWidget {
  final String productId;

  const ReviewInput({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReviewController>();

    return Container(
      padding: const EdgeInsets.all(ConstantSizes.md),
      decoration: BoxDecoration(
        color: ConstantColors.white,
        borderRadius: BorderRadius.circular(ConstantSizes.cardRadiusLg),
        border: Border.all(color: ConstantColors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Write a Review',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: ConstantSizes.spaceBtwItems),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 28,
            unratedColor: ConstantColors.grey,
            itemBuilder: (context, _) => const Icon(
              Iconsax.star1,
              color: ConstantColors.primary,
            ),
            onRatingUpdate: (rating) => controller.rating.value = rating,
          ),
          const SizedBox(height: ConstantSizes.spaceBtwItems),
          TextFormField(
            controller: controller.reviewTextController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Share your thoughts about this product...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: ConstantSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (controller.rating.value == 0) {
                  Get.snackbar(
                    'Rating Required',
                    'Please rate the product before submitting',
                    colorText: ConstantColors.white,
                    backgroundColor: ConstantColors.error,
                  );
                  return;
                }
                if (controller.reviewTextController.text.trim().isEmpty) {
                  Get.snackbar(
                    'Review Required',
                    'Please write your review before submitting',
                    colorText: ConstantColors.white,
                    backgroundColor: ConstantColors.error,
                  );
                  return;
                }
                controller.addReview(
                  productId,
                  controller.rating.value,
                  controller.reviewTextController.text.trim(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstantColors.primary,
                padding: const EdgeInsets.all(ConstantSizes.md),
              ),
              child: const Text('Submit Review'),
            ),
          ),
        ],
      ),
    );
  }
}
