import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';

class CustomProfileInformation extends StatelessWidget {
  const CustomProfileInformation({
    super.key,
    this.icon = Iconsax.arrow_right_34,
    required this.onTap,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: ConstantSizes.spaceBtwItems / 2),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: dark
                        ? ConstantColors.buttonSecondary
                        : ConstantColors.darkGrey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Icon(
                icon,
                size: 18,
                color: dark
                    ? ConstantColors.buttonSecondary
                    : ConstantColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
