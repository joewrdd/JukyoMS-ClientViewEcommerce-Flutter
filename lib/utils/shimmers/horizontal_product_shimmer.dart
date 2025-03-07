import 'package:flutter/material.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/shimmers/shimmer.dart';

class THorizontalProductShimmer extends StatelessWidget {
  const THorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ConstantSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: ConstantSizes.spaceBtwItems,
        ),
        itemBuilder: (_, __) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Thumbnail
            const TShimmerEffect(width: 120, height: 120),
            const SizedBox(width: ConstantSizes.spaceBtwItems),

            // Details
            SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  TShimmerEffect(width: 160, height: 15),
                  TShimmerEffect(width: 110, height: 15),
                  TShimmerEffect(width: 80, height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
