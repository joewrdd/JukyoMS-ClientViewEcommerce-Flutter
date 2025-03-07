import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  //----- Get All Images From Product & Variations -----
  List<String> getAllProductImages(ProductModel product) {
    // Use Set To Avoid Duplicate Images
    Set<String> images = {};

    // // Add Product Thumbnail
    // images.add(product.thumbnail);

    // Assign Thumbnail To The Selected Image
    selectedProductImage.value = product.images!.first;

    // Get All Product Images From ProductModel If Not Null
    if (product.images != null) {
      images.addAll(product.images!);
    }

    // Get All Product Images From Product Variations If Not Null
    // if (product.productVariations != null ||
    //     product.productVariations!.isNotEmpty) {
    //   images.addAll(
    //       product.productVariations!.map((variation) => variation.image));
    // }

    return images.toList();
  }

  //----- Show Image Popup -----
  void showEnlargedImage(String imageUrl) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: ConstantSizes.defaultSpace * 2,
                  horizontal: ConstantSizes.defaultSpace),
              child: CachedNetworkImage(imageUrl: imageUrl),
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwSections,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Close',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
