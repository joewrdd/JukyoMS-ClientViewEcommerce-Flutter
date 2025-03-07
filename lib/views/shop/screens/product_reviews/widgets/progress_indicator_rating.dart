import 'package:flutter/material.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/device/device_utility.dart';

class CustomRatingProgressIndicator extends StatelessWidget {
  const CustomRatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          width: ConstantSizes.spaceBtwItems / 2,
        ),
        SizedBox(
          width: DeviceUtils.getScreenWidth(context) * 0.5,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 11,
            backgroundColor: ConstantColors.grey,
            valueColor: AlwaysStoppedAnimation(
              ConstantColors.primary,
            ),
            borderRadius: BorderRadius.circular(
              7,
            ),
          ),
        ),
      ],
    );
  }
}
