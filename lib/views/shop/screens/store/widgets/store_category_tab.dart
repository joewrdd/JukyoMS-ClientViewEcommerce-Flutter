import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/common/widgets/layouts/gridview_layout.dart';
import 'package:jukyo_ms/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/cloud.dart';
import 'package:jukyo_ms/utils/shimmers/vertical_product_shimmer.dart';
import 'package:jukyo_ms/views/shop/controllers/category_controller.dart';
import 'package:jukyo_ms/views/shop/models/brand_model.dart';
import 'package:jukyo_ms/views/shop/models/category_model.dart';
import 'package:jukyo_ms/views/shop/screens/store/widgets/store_category_brands.dart';
import 'package:jukyo_ms/views/shop/screens/view_all_products/view_all_products.dart';

class StoreCategoryTab extends StatelessWidget {
  const StoreCategoryTab(
      {super.key, required this.category, required this.brandModel});

  final CategoryModel category;
  final BrandModel brandModel;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(ConstantSizes.defaultSpace),
          child: Column(
            children: [
              // Brands
              StoreCategoryBrands(category: category),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              // Products
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  // Handles Any Loader, No Record, Error.
                  final widget = CloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: const VerticalProductShimmer());
                  if (widget != null) return widget;
                  // Record Found
                  final categoryProducts = snapshot.data!;
                  return Column(
                    children: [
                      CustomSectionHeader(
                        title: 'You Might Like',
                        showActionButton: true,
                        onPressed: () => Get.to(
                          ViewAllProductsScreen(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(
                              categoryId: category.id,
                              limit: -1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: ConstantSizes.spaceBtwItems,
                      ),
                      CustomGridViewLayout(
                        itemCount: categoryProducts.length,
                        mainAxisExtent: 290,
                        itemBuilder: (ctx, index) => CustomProductCardVertical(
                          product: categoryProducts[index],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
