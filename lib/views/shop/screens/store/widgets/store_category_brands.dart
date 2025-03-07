import 'package:flutter/material.dart';
import 'package:jukyo_ms/common/widgets/brands/brand_card_showcase.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/cloud.dart';
import 'package:jukyo_ms/utils/shimmers/boxes_shimmer.dart';
import 'package:jukyo_ms/utils/shimmers/list_title_shimmer.dart';
import 'package:jukyo_ms/views/shop/controllers/brand_controller.dart';
import 'package:jukyo_ms/views/shop/models/category_model.dart';

class StoreCategoryBrands extends StatelessWidget {
  const StoreCategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          const loader = Column(
            children: [
              TListTitleShimmer(),
              SizedBox(height: ConstantSizes.spaceBtwItems),
              TBoxesShimmer(),
              SizedBox(height: ConstantSizes.spaceBtwItems),
            ],
          );
          final widget = CloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;
          // Record Found
          final brands = snapshot.data!;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final brand = brands[index];
                return FutureBuilder(
                    future: controller.getBrandProducts(
                        brandId: brand.id, limit: 3),
                    builder: (context, snapshot) {
                      // Handle Loader
                      final widget = CloudHelperFunctions.checkMultiRecordState(
                          snapshot: snapshot, loader: loader);
                      if (widget != null) return widget;

                      // Record Found
                      final products = snapshot.data!;
                      final images = products.map((e) => e.thumbnail).toList();
                      return CustomBrandShowcase(
                        brand: brand,
                        images: images,
                      );
                    });
              });
        });
  }
}
