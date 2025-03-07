import 'package:flutter/material.dart';
import 'package:jukyo_ms/views/shop/screens/product_reviews/widgets/progress_indicator_rating.dart';

class OverallProductRating extends StatelessWidget {
  final double rating;
  final List<int> ratingCounts;
  final int totalRating;

  const OverallProductRating({
    super.key,
    required this.rating,
    required this.ratingCounts,
    required this.totalRating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            rating.toStringAsFixed(1),
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              for (int i = 4; i >= 0; i--)
                CustomRatingProgressIndicator(
                  text: '${i + 1}',
                  value: totalRating > 0 ? ratingCounts[i] / totalRating : 0,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
