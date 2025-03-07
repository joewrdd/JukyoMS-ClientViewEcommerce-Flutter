import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/custom/icons/circular_icon.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';

class CustomProductQuantityAddRemoveButton extends StatelessWidget {
  const CustomProductQuantityAddRemoveButton({
    super.key,
    required this.quantity,
    this.onAdd,
    this.onRemove,
  });

  final int quantity;
  final VoidCallback? onAdd, onRemove;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: ConstantSizes.md,
          color: dark ? ConstantColors.white : ConstantColors.black,
          backgroundColor:
              dark ? ConstantColors.darkGrey : ConstantColors.lightGrey,
          onPressed: onRemove,
        ),
        const SizedBox(
          width: ConstantSizes.spaceBtwItems,
        ),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: ConstantSizes.spaceBtwItems,
        ),
        CustomCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: ConstantSizes.md,
          color: ConstantColors.white,
          backgroundColor: ConstantColors.primary,
          onPressed: onAdd,
        ),
      ],
    );
  }
}
