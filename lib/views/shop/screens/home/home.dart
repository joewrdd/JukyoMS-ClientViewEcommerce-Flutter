import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/circular_container.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/curved_edges.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/custom_searchbar.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/common/widgets/layouts/gridview_layout.dart';
import 'package:jukyo_ms/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:jukyo_ms/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/constants/texts.dart';
import 'package:jukyo_ms/utils/shimmers/vertical_product_shimmer.dart';
import 'package:jukyo_ms/views/shop/controllers/products/product_controller.dart';
import 'package:jukyo_ms/views/shop/screens/home/widgets/home_categories.dart';
import 'package:jukyo_ms/views/shop/screens/home/widgets/home_promo_slider.dart';
import 'package:jukyo_ms/views/shop/screens/view_all_products/view_all_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            ClipPath(
              clipper: CustomCurvedEdges(),
              child: Container(
                color: ConstantColors.primary,
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: 400,
                  // Stacked Circular Container
                  child: Stack(
                    children: [
                      Positioned(
                        top: -150,
                        right: -300,
                        child: CustomCircularContainer(
                          backgroundColor:
                              ConstantColors.buttonSecondary.withOpacity(0.4),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        right: -250,
                        child: CustomCircularContainer(
                          backgroundColor:
                              ConstantColors.buttonSecondary.withOpacity(0.4),
                        ),
                      ),
                      Column(
                        children: [
                          // Appbar
                          CustomAppBar(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ConstantTexts.homeAppbarTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(
                                        color: ConstantColors.grey,
                                      ),
                                ),
                                Text(
                                  ConstantTexts.homeAppbarSubTitle,
                                  style: GoogleFonts.aDLaMDisplay(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    color: ConstantColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              CartCounterIcon(
                                iconColor: ConstantColors.white,
                                textColor: ConstantColors.black,
                                containerColor: ConstantColors.white,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: ConstantSizes.spaceBtwSections,
                          ),
                          // Searchbar
                          CustomSearchContainer(
                            text: 'Search In Store',
                          ),
                          const SizedBox(
                            height: ConstantSizes.spaceBtwSections,
                          ),
                          // Heading & Categories
                          Padding(
                            padding: EdgeInsets.only(
                              left: ConstantSizes.defaultSpace,
                            ),
                            child: Column(
                              children: [
                                // Heading
                                CustomSectionHeader(
                                  title: 'Popular Categories',
                                  showActionButton: false,
                                  textColor: ConstantColors.white,
                                ),
                                const SizedBox(
                                  height: ConstantSizes.spaceBtwItems,
                                ),
                                // Categories
                                HomeCategories(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // BODY
            Padding(
              padding: const EdgeInsets.all(
                ConstantSizes.defaultSpace,
              ),
              // Home Body Image Slider
              child: Column(
                children: [
                  HomePromoSlider(),
                  const SizedBox(
                    height: ConstantSizes.spaceBtwSections,
                  ),
                  CustomSectionHeader(
                    title: 'Popular Products',
                    onPressed: () => Get.to(
                      () => ViewAllProductsScreen(
                        title: 'Popular Products',
                        query: FirebaseFirestore.instance
                            .collection('Products')
                            .where('IsFeatured', isEqualTo: true)
                            .limit(6),
                        futureMethod: controller.fetchAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: ConstantSizes.spaceBtwItems,
                  ),
                  // Popular Product Cards
                  Obx(() {
                    if (controller.isLoading.value) {
                      return VerticalProductShimmer();
                    }
                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No Products Found',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    return CustomGridViewLayout(
                      itemBuilder: (ctx, index) => CustomProductCardVertical(
                        product: controller.featuredProducts[index],
                      ),
                      itemCount: controller.featuredProducts.length,
                      mainAxisExtent: 288,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// Cross Axis => Horizontal
// Main Axis => Vertical