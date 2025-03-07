import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/custom/images/rounded_image.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/cloud.dart';
import 'package:jukyo_ms/utils/shimmers/horizontal_product_shimmer.dart';
import 'package:jukyo_ms/views/shop/controllers/category_controller.dart';
import 'package:jukyo_ms/views/shop/models/category_model.dart';
import 'package:jukyo_ms/views/shop/screens/view_all_products/view_all_products.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ConstantSizes.defaultSpace),
          child: Column(
            children: [
              // Banner
              CustomRoundedImage(
                imageUrl: ConstantImages.mainBanner,
                applyImageRadius: true,
                width: double.infinity,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwSections),

              // Sub Categories
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {
                  // Handle Loading State
                  const loader = THorizontalProductShimmer();
                  final widget = CloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  // Record Found
                  final subCategories = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final subCategory = subCategories[index];
                      return FutureBuilder(
                        future: controller.getCategoryProducts(
                          categoryId: subCategory.id,
                        ),
                        builder: (context, snapshot) {
                          // Handle Loading State
                          final widget =
                              CloudHelperFunctions.checkMultiRecordState(
                                  snapshot: snapshot, loader: loader);
                          if (widget != null) return widget;

                          // Record Found
                          final products = snapshot.data!;
                          return Column(
                            children: [
                              CustomSectionHeader(
                                title: subCategory.name,
                                onPressed: () => Get.to(
                                  () => ViewAllProductsScreen(
                                    title: subCategory.name,
                                    futureMethod:
                                        controller.getCategoryProducts(
                                      categoryId: subCategory.id,
                                      limit: -1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: ConstantSizes.spaceBtwItems / 2,
                              ),
                              SizedBox(
                                height: 140,
                                child: ListView.separated(
                                  itemCount: products.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: ConstantSizes.spaceBtwItems,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (ctx, index) {
                                    return CustomProductCardHorizontal(
                                      product: products[index],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: ConstantSizes.spaceBtwSections,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
