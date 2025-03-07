import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/rounded_container.dart';
import 'package:jukyo_ms/common/widgets/brands/brand_card.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/utils/shimmers/shimmer.dart';
import 'package:jukyo_ms/views/shop/models/brand_model.dart';
import 'package:jukyo_ms/views/shop/screens/view_all_brands/brand_products.dart';

class CustomBrandShowcase extends StatelessWidget {
  const CustomBrandShowcase({
    super.key,
    required this.images,
    required this.brand,
  });

  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProductsScreen(brand: brand)),
      child: CustomRoundedContainer(
        showBorder: true,
        borderColor: ConstantColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(ConstantSizes.md),
        margin: const EdgeInsets.only(
          bottom: ConstantSizes.spaceBtwItems,
        ),
        child: Column(
          children: [
            // Brand With Products Count
            CustomBrandCard(
              brand: brand,
              showBorder: false,
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwItems,
            ),
            // Brand Top 3 Product Images
            Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context) {
  final dark = HelperFunctions.isDarkMode(context);

  return Expanded(
    child: CustomRoundedContainer(
      height: 100,
      backgroundColor: dark ? ConstantColors.darkerGrey : ConstantColors.light,
      margin: const EdgeInsets.only(right: ConstantSizes.sm),
      padding: const EdgeInsets.all(ConstantSizes.md),
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: image,
        progressIndicatorBuilder: (context, url, progress) =>
            const TShimmerEffect(width: 100, height: 100),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    ),
  );
}
