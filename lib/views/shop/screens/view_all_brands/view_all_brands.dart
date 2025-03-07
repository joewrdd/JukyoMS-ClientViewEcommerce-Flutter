import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/brands/brand_card.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/common/widgets/layouts/gridview_layout.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/shimmers/brand_shimmer.dart';
import 'package:jukyo_ms/views/shop/controllers/brand_controller.dart';
import 'package:jukyo_ms/views/shop/screens/view_all_brands/brand_products.dart';

class ViewAllBrandsScreen extends StatelessWidget {
  const ViewAllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Brands'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ConstantSizes.defaultSpace),
          child: Column(
            children: [
              // Heading
              CustomSectionHeader(
                title: 'All Available Brands',
                showActionButton: false,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              // Brands
              Obx(
                () {
                  if (brandController.isLoading.value) {
                    return TBrandShimmer();
                  }
                  if (brandController.featuredBrands.isEmpty) {
                    return Center(
                      child: Text(
                        'No Brands Found!',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: ConstantColors.buttonSecondary,
                            ),
                      ),
                    );
                  }
                  return CustomGridViewLayout(
                    itemCount: brandController.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (ctx, index) {
                      final brand = brandController.allBrands[index];
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
      ),
    );
  }
}
