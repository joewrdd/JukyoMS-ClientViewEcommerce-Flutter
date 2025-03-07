import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/custom/images/vertical_image_text.dart';
import 'package:jukyo_ms/utils/shimmers/category_shimmer.dart';
import 'package:jukyo_ms/views/shop/controllers/category_controller.dart';
import 'package:jukyo_ms/views/shop/screens/sub_categories/sub_categories.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) return const TCategoryShimmer();
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Found',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final category = categoryController.featuredCategories[index];
            return CustomVerticalImageText(
              image: category.image,
              title: category.name,
              onTap: () => Get.to(
                () => SubCategoriesScreen(category: category),
              ),
            );
          },
        ),
      );
    });
  }
}
