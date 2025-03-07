import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/brand_title_text.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/enums/enums.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';

class CustomBrandTitleWithVerifiedIcon extends StatelessWidget {
  const CustomBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = ConstantColors.thirdly,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: CustomBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(
          width: ConstantSizes.xs,
        ),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: ConstantSizes.iconXs,
        ),
      ],
    );
  }
}
