import 'package:flutter/material.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/views/shop/controllers/review_controller.dart';
import 'package:jukyo_ms/views/shop/screens/product_reviews/widgets/rating_bar.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/views/shop/screens/product_reviews/widgets/overall_progress_indicator.dart';
import 'package:jukyo_ms/views/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/views/shop/screens/product_reviews/widgets/review_input.dart';

class ProductReviewsScreen extends GetView<ReviewController> {
  final String productId;
  const ProductReviewsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: CustomAppBar(
        title: const Text('Reviews & Ratings'),
        showBackArrow: true,
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ConstantSizes.defaultSpace),
          child: Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.hasError.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error loading reviews',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwItems),
                      Text(
                        controller.errorMessage.value,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwItems),
                      ElevatedButton(
                        onPressed: () =>
                            controller.loadProductReviews(productId),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              final stats = controller.productStats.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating Stats
                  Container(
                    padding: const EdgeInsets.all(ConstantSizes.md),
                    decoration: BoxDecoration(
                      color: ConstantColors.white,
                      borderRadius:
                          BorderRadius.circular(ConstantSizes.cardRadiusLg),
                      border: Border.all(
                          color: ConstantColors.grey.withOpacity(0.1)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Ratings and reviews are verified and are from people who use the same type of device that you use.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwItems),
                        OverallProductRating(
                          rating: stats['average'] ?? 0.0,
                          ratingCounts: stats['ratingCounts'] as List<int>? ??
                              List.filled(5, 0),
                          totalRating: stats['total'] ?? 0,
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwItems),
                        CustomRatingBarIndicator(
                          rating: stats['average'] ?? 0.0,
                        ),
                        Text(
                          '${stats['total'] ?? 0} Reviews',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  // Review Input
                  ReviewInput(productId: productId),
                  const SizedBox(height: ConstantSizes.spaceBtwSections),

                  // Reviews List
                  if (controller.reviews.isEmpty)
                    Center(
                      child: Text(
                        'No reviews yet. Be the first to review!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  else
                    ...controller.reviews
                        .map((review) => UserReviewCard(
                              review: review,
                              onDeletePressed: () =>
                                  controller.deleteReview(review.id, productId),
                            ))
                        .toList(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
