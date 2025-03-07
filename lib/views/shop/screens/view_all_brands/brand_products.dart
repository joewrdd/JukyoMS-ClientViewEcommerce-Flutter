import 'package:flutter/material.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/brands/brand_card.dart';
import 'package:jukyo_ms/common/widgets/products/sortable/sortable_products.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/cloud.dart';
import 'package:jukyo_ms/utils/shimmers/vertical_product_shimmer.dart';
import 'package:jukyo_ms/views/shop/controllers/brand_controller.dart';
import 'package:jukyo_ms/views/shop/models/brand_model.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          brand.name,
          style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            ConstantSizes.defaultSpace,
          ),
          child: Column(
            children: [
              // Brand Details
              CustomBrandCard(
                showBorder: true,
                brand: brand,
              ),
              SizedBox(
                height: ConstantSizes.spaceBtwSections,
              ),
              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    // Handles Any Loader, No Record, Error.
                    const loader = VerticalProductShimmer();
                    final widget = CloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;
                    // Record Found
                    final brandProducts = snapshot.data!;
                    return CustomSortableProducts(
                      products: brandProducts,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
