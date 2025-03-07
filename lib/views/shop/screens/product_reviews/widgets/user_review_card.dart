import 'package:flutter/material.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/rounded_container.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/shop/screens/product_reviews/widgets/rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:jukyo_ms/data/repos/authentication/auth_repo.dart';
import 'package:jukyo_ms/views/shop/models/review_model.dart';

class UserReviewCard extends StatelessWidget {
  final ReviewModel review;
  final VoidCallback? onDeletePressed;

  const UserReviewCard({
    super.key,
    required this.review,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final currentUserId = AuthenticationRepository.instance.authUser?.uid;
    final isOwner = currentUserId == review.userId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: review.userImage.isNotEmpty
                      ? NetworkImage(review.userImage)
                      : const AssetImage(ConstantImages.userProfileImage1)
                          as ImageProvider,
                ),
                const SizedBox(width: ConstantSizes.spaceBtwItems),
                Text(
                  review.userName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            if (isOwner)
              IconButton(
                onPressed: onDeletePressed,
                icon: const Icon(Icons.delete_outline),
              ),
          ],
        ),
        const SizedBox(height: ConstantSizes.spaceBtwItems),
        Row(
          children: [
            CustomRatingBarIndicator(rating: review.rating),
            const SizedBox(width: ConstantSizes.spaceBtwItems),
            Text(
              HelperFunctions.getFormattedDate(review.createdAt),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: ConstantSizes.spaceBtwItems),
        Align(
          alignment: Alignment.centerLeft,
          child: ReadMoreText(
            review.comment,
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Show More',
            trimExpandedText: ' Less',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium,
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
        ),
        if (review.companyResponse != null) ...[
          const SizedBox(height: ConstantSizes.spaceBtwItems),
          CustomRoundedContainer(
            backgroundColor:
                dark ? ConstantColors.darkerGrey : ConstantColors.grey,
            child: Padding(
              padding: const EdgeInsets.all(ConstantSizes.md),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Company Response',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (review.companyResponseDate != null)
                        Text(
                          HelperFunctions.getFormattedDate(
                              review.companyResponseDate!),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                  const SizedBox(height: ConstantSizes.spaceBtwItems),
                  ReadMoreText(
                    review.companyResponse!,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show More',
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
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: ConstantSizes.spaceBtwSections),
      ],
    );
  }
}
