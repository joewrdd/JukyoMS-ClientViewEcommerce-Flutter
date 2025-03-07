import 'package:flutter/material.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/rounded_container.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';

class CustomCouponCode extends StatelessWidget {
  const CustomCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return CustomRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? ConstantColors.dark : ConstantColors.white,
      padding: const EdgeInsets.only(
        top: ConstantSizes.sm,
        bottom: ConstantSizes.sm,
        right: ConstantSizes.sm,
        left: ConstantSizes.md,
      ),
      child: Row(
        children: [
          // TextField
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Have a promo code? Enter Here...',
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          // Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: dark
                    ? ConstantColors.white.withOpacity(0.5)
                    : ConstantColors.dark.withOpacity(0.5),
                backgroundColor: Colors.grey.withOpacity(0.2),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
              child: const Text(
                'Apply',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
