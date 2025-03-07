import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/views/shop/controllers/banner_controller.dart';
import 'package:jukyo_ms/views/shop/controllers/category_controller.dart';
import 'package:jukyo_ms/views/shop/controllers/products/product_controller.dart';

class LoadDataScreen extends StatelessWidget {
  const LoadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final bannerController = Get.put(BannerController());
    final productController = ProductController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Load Data',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // New Section Header for Main Record
              CustomSectionHeader(
                title: 'Main Record',
                showActionButton: false,
              ),
              const SizedBox(height: 16.0),

              // Custom Settings Menu Tile for Uploading Dummy Data
              CustomSettingsMenuTile(
                icon: Iconsax.category,
                title: 'Upload Categories',
                trailing: IconButton(
                    onPressed: categoryController.uploadCategories,
                    icon: Icon(Iconsax.document_download),
                    color: ConstantColors.buttonSecondary),
                subtitle: 'Load Categories From Firebase',
              ),
              CustomSettingsMenuTile(
                icon: Iconsax.gallery,
                title: 'Upload Banners',
                trailing: IconButton(
                    onPressed: bannerController.uploadBanners,
                    icon: Icon(Iconsax.document_download),
                    color: ConstantColors.buttonSecondary),
                subtitle: 'Load Banners From Firebase',
              ),
              CustomSettingsMenuTile(
                icon: Iconsax.box,
                title: 'Upload Products',
                trailing: IconButton(
                    onPressed: productController.uploadProducts,
                    icon: Icon(Iconsax.document_download),
                    color: ConstantColors.buttonSecondary),
                subtitle: 'Load Products From Firebase',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
