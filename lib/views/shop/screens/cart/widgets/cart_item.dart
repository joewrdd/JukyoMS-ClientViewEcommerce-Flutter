import 'package:flutter/material.dart';
import 'package:jukyo_ms/common/widgets/custom/images/rounded_image.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/brand_title_text_with_verified.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/product_title_text.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/shop/models/cart_item_model.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Row(
      children: [
        // Image
        CustomRoundedImage(
          imageUrl: cartItem.image ?? '',
          isNetworkImage: true,
          width: 60,
          height: 60,
          padding: EdgeInsets.all(ConstantSizes.sm),
          backgroundColor:
              dark ? ConstantColors.darkerGrey : ConstantColors.light,
        ),
        const SizedBox(
          width: ConstantSizes.spaceBtwItems,
        ),
        // Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
              Flexible(
                child: CustomProductTitleText(
                  title: cartItem.title,
                  maxLines: 1,
                ),
              ),
              // Attributes
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {})
                      .entries
                      .map(
                        (e) => TextSpan(
                          children: [
                            TextSpan(
                                text: ' ${e.key} ',
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: ' ${e.value} ',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
