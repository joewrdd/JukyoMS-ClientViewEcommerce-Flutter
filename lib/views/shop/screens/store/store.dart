import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/appbar/tabbar.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/custom_searchbar.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/common/widgets/layouts/gridview_layout.dart';
import 'package:jukyo_ms/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:jukyo_ms/common/widgets/brands/brand_card.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/utils/shimmers/brand_shimmer.dart';
import 'package:jukyo_ms/views/shop/controllers/brand_controller.dart';
import 'package:jukyo_ms/views/shop/controllers/category_controller.dart';
import 'package:jukyo_ms/views/shop/models/brand_model.dart';
import 'package:jukyo_ms/views/shop/screens/store/widgets/store_category_tab.dart';
import 'package:jukyo_ms/views/shop/screens/view_all_brands/brand_products.dart';
import 'package:jukyo_ms/views/shop/screens/view_all_brands/view_all_brands.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance.featuredCategories;
    final brandController = Get.put(BrandController());
    final dark = HelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: categoryController.length,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            CartCounterIcon(
              iconColor: dark ? ConstantColors.white : ConstantColors.black,
              containerColor:
                  dark ? ConstantColors.white : ConstantColors.black,
              textColor: dark ? ConstantColors.black : ConstantColors.white,
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (ctx, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor:
                    dark ? ConstantColors.black : ConstantColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(ConstantSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Search Bar
                      SizedBox(
                        height: ConstantSizes.spaceBtwItems,
                      ),
                      CustomSearchContainer(
                        text: 'Search In Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(
                        height: ConstantSizes.spaceBtwSections,
                      ),
                      // Feature Brands
                      CustomSectionHeader(
                        title: 'Featured Brands',
                        onPressed: () => Get.to(
                          () => ViewAllBrandsScreen(),
                        ),
                      ),
                      const SizedBox(
                        height: ConstantSizes.spaceBtwItems / 1.5,
                      ),
                      Obx(
                        () {
                          if (brandController.isLoading.value) {
                            return TBrandShimmer();
                          }
                          if (brandController.featuredBrands.isEmpty) {
                            return Center(
                              child: Text(
                                'No Featured Brands Found!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color: ConstantColors.buttonSecondary,
                                    ),
                              ),
                            );
                          }
                          return CustomGridViewLayout(
                            itemCount: brandController.featuredBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (ctx, index) {
                              final brand =
                                  brandController.featuredBrands[index];
                              return CustomBrandCard(
                                brand: brand,
                                showBorder: true,
                                onTap: () => Get.to(
                                  () => BrandProductsScreen(
                                    brand: brand,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // TabBar with Scrolling Categories
                bottom: CustomTabBar(
                    tabs: categoryController
                        .map((element) => Tab(child: Text(element.name)))
                        .toList()),
              ),
            ];
          },
          body: TabBarView(
            children: categoryController
                .map((category) => StoreCategoryTab(
                      category: category,
                      brandModel: BrandModel(
                        id: category.id,
                        name: category.name,
                        image: category.image,
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
