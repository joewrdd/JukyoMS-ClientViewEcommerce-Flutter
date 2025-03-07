import 'package:flutter/material.dart';
import 'package:jukyo_ms/common/widgets/custom/images/circular_image.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/brand_title_text_with_verified.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/enums/enums.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/shop/models/brand_model.dart';

class CustomBrandCard extends StatelessWidget {
  const CustomBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.brand,
  });

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(ConstantSizes.sm - 4),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(
            ConstantSizes.cardRadiusLg,
          ),
          border: showBorder
              ? Border.all(
                  color: ConstantColors.borderPrimary,
                )
              : null,
        ),
        child: Row(
          children: [
            // Icon
            Flexible(
              child: CustomCircularImage(
                width: 48,
                height: 48,
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: Colors.transparent,
                overlayColor:
                    dark ? ConstantColors.white : ConstantColors.black,
              ),
            ),
            const SizedBox(
              width: ConstantSizes.spaceBtwItems / 2,
            ),
            // Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBrandTitleWithVerifiedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.medium,
                  ),
                  Text(
                    '${brand.productsCount ?? 0} Products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
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
