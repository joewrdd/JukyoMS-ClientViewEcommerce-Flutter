import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/custom/icons/circular_icon.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/views/shop/controllers/products/favorites_controller.dart';

class CustomFavoriteIcon extends StatelessWidget {
  const CustomFavoriteIcon({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    return Obx(() {
      return CustomCircularIcon(
        icon: controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavorite(productId) ? ConstantColors.error : null,
        backgroundColor: Colors.transparent,
        onPressed: () => controller.toggleFavorite(productId),
      );
    });
  }
}
