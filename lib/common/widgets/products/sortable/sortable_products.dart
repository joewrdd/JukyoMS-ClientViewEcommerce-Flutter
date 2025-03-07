import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/layouts/gridview_layout.dart';
import 'package:jukyo_ms/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/views/shop/controllers/products/all_products_controller.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class CustomSortableProducts extends StatelessWidget {
  const CustomSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // Controller For Managing Products Sorting
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField(
          style: TextStyle(color: Colors.black, fontSize: 15),
          dropdownColor: ConstantColors.lightGrey,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            labelText: 'Sort By',
            border: OutlineInputBorder(),
            prefixIconColor: ConstantColors.primary,
            prefixIcon: Icon(
              Iconsax.sort,
            ),
          ),
          items: [
            'Name',
            'Highest Price',
            'Lowest Price',
            'Sale',
            'Newest',
            'Most Popular'
          ]
              .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(color: ConstantColors.primary),
                  )))
              .toList(),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            // Sort Products Based On Selected Option
            controller.sortProducts(value!);
          },
        ),
        const SizedBox(
          height: ConstantSizes.spaceBtwSections,
        ),
        // Products
        Obx(
          () {
            return CustomGridViewLayout(
              itemCount: controller.products.length,
              itemBuilder: (ctx, index) => CustomProductCardVertical(
                product: controller.products[index],
              ),
              mainAxisExtent: 275,
            );
          },
        ),
      ],
    );
  }
}
