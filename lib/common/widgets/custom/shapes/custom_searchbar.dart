import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/device/device_utility.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';

class CustomSearchContainer extends StatelessWidget {
  const CustomSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(
      horizontal: ConstantSizes.defaultSpace,
    ),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: DeviceUtils.getScreenWidth(context),
          padding: EdgeInsets.all(
            ConstantSizes.md,
          ),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? ConstantColors.dark
                    : ConstantColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              ConstantSizes.cardRadiusLg,
            ),
            border: showBorder
                ? Border.all(
                    color: ConstantColors.grey,
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: ConstantColors.darkerGrey,
              ),
              const SizedBox(
                width: ConstantSizes.spaceBtwItems,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
