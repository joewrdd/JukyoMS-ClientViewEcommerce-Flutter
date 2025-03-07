import 'package:flutter/material.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';

class CustomCircularIcon extends StatelessWidget {
  // A Custom Circular Icon Widget With Background Color
  //
  // Properties are:
  // Container [width], [height], & [backgroundColor].
  //
  // Icon's [size], [color] & [onPressed]

  const CustomCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = ConstantSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null
            ? backgroundColor!
            : HelperFunctions.isDarkMode(context)
                ? ConstantColors.black.withOpacity(0.9)
                : ConstantColors.light,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
