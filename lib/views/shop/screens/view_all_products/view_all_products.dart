import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/products/sortable/sortable_products.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/cloud.dart';
import 'package:jukyo_ms/utils/shimmers/vertical_product_shimmer.dart';
import 'package:jukyo_ms/views/shop/controllers/products/all_products_controller.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class ViewAllProductsScreen extends StatelessWidget {
  const ViewAllProductsScreen(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          title,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            ConstantSizes.defaultSpace,
          ),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                // Check State Of FutureBuilder Snapshot
                const loader = VerticalProductShimmer();
                final recordHelperWidget =
                    CloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                if (recordHelperWidget != null) return recordHelperWidget;

                // Products Found
                final products = snapshot.data!;
                // Return CustomSortableProducts
                return CustomSortableProducts(
                  products: products,
                );
              }),
        ),
      ),
    );
  }
}
