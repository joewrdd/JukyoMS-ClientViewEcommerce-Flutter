import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/custom/icons/circular_icon.dart';
import 'package:jukyo_ms/common/widgets/layouts/gridview_layout.dart';
import 'package:jukyo_ms/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:jukyo_ms/navigation.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/cloud.dart';
import 'package:jukyo_ms/utils/loaders/animation.dart';
import 'package:jukyo_ms/utils/shimmers/vertical_product_shimmer.dart';
import 'package:jukyo_ms/views/shop/controllers/products/favorites_controller.dart';
import 'package:jukyo_ms/views/shop/screens/view_all_brands/view_all_brands.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CustomCircularIcon(
            backgroundColor: Colors.transparent,
            icon: Iconsax.add,
            onPressed: () => Get.to(
              ViewAllBrandsScreen(),
            ),
          ),
        ],
      ),
      // Items In Wishlist
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            ConstantSizes.defaultSpace,
          ),
          child: Obx(
            () => FutureBuilder(
              future: controller.favoriteProducts(),
              builder: (context, snapshot) {
                final emptyWidget = SizedBox(
                  height: 600,
                  child: AnimationLoaderWidget(
                    text: 'Whoops! Wishlist Is Empty...',
                    animation: ConstantImages.wishListAni,
                    animationType: AnimationType.gif,
                    showAction: true,
                    actionText: "Let's Add Some!",
                    onActionPressed: () => Get.off(
                      () => const NavigationMenu(),
                    ),
                  ),
                );

                const loader = VerticalProductShimmer(
                  itemCount: 6,
                );
                final widget = CloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                    nothingFound: emptyWidget);
                if (widget != null) return widget;

                final products = snapshot.data!;
                return CustomGridViewLayout(
                  itemCount: products.length,
                  mainAxisExtent: 290,
                  itemBuilder: (ctx, index) => CustomProductCardVertical(
                    product: products[index],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
