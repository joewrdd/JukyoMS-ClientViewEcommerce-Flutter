import 'package:flutter/material.dart';
import 'package:jukyo_ms/common/widgets/custom/images/circular_image.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/rounded_container.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/brand_title_text_with_verified.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/product_price_text.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/product_title_text.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/enums/enums.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/enums/product_type.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/shop/controllers/products/product_controller.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class CustomProductMetaData extends StatelessWidget {
  const CustomProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        CustomProductTitleText(title: product.title),
        const SizedBox(
          height: ConstantSizes.spaceBtwItems / 1.5,
        ),
        // Price & Sale Price
        Row(
          children: [
            // Price
            CustomProductPriceText(
              price: controller.getProductPrice(product),
              isLarge: true,
            ),
            const SizedBox(
              width: ConstantSizes.spaceBtwItems - 6,
            ),
            // Price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                '\$${product.price}',
                style: Theme.of(context).textTheme.titleSmall!.apply(
                      decoration: TextDecoration.lineThrough,
                    ),
              ),
            const SizedBox(
              width: ConstantSizes.spaceBtwItems - 6,
            ),
            // Sale Price
            CustomRoundedContainer(
              radius: ConstantSizes.sm,
              backgroundColor: (product.salePrice > 0)
                  ? ConstantColors.secondary.withOpacity(0.8)
                  : Colors.transparent,
              padding: const EdgeInsets.symmetric(
                  horizontal: ConstantSizes.sm, vertical: ConstantSizes.xs),
              child: (product.salePrice > 0)
                  ? Text(
                      '$salePercentage%',
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                            color: ConstantColors.black,
                          ),
                    )
                  : Text(''),
            ),
          ],
        ),
        const SizedBox(
          height: ConstantSizes.spaceBtwItems / 1.5,
        ),
        // Stock Status
        Row(
          children: [
            CustomProductTitleText(
              title: 'Status:',
              smallSize: true,
            ),
            const SizedBox(
              width: ConstantSizes.sm,
            ),
            Text(
              controller.getStockStatus(product.stock),
              style: Theme.of(context).textTheme.labelSmall!.apply(
                    color: product.stock > 0
                        ? ConstantColors.success
                        : ConstantColors.error,
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: ConstantSizes.spaceBtwItems / 1.5,
        ),
        // Brand
        Row(
          children: [
            CustomCircularImage(
              image: product.brand != null ? product.brand!.image : '',
              height: 45,
              width: 45,
              overlayColor: dark ? ConstantColors.white : ConstantColors.black,
            ),
            CustomBrandTitleWithVerifiedIcon(
              title: product.brand != null ? product.brand!.name : '',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
