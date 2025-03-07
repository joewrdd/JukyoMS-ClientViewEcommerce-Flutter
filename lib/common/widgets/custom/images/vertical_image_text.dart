import 'package:flutter/material.dart';
import 'package:jukyo_ms/common/widgets/custom/images/circular_image.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';

class CustomVerticalImageText extends StatelessWidget {
  const CustomVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = ConstantColors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          right: ConstantSizes.spaceBtwItems * 1.1,
        ),
        child: Column(
          children: [
            // Cicular Icon
            CustomCircularImage(
              image: image,
              radius: 0,
              padding: ConstantSizes.sm * 1.1,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: dark ? ConstantColors.light : ConstantColors.dark,
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwItems / 2,
            ),
            SizedBox(
              width: 71,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: textColor,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
