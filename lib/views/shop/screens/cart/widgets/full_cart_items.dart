import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/product_price_text.dart';
import 'package:jukyo_ms/common/widgets/products/cart/add_remove_quantity.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/views/shop/controllers/products/cart_controller.dart';
import 'package:jukyo_ms/views/shop/screens/cart/widgets/cart_item.dart';

class FullCartItems extends StatelessWidget {
  const FullCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () {
        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(
            height: ConstantSizes.spaceBtwSections,
          ),
          itemCount: controller.cartItems.length,
          itemBuilder: (ctx, index) => Obx(
            () {
              final item = controller.cartItems[index];
              return Column(
                children: [
                  // Cart Item (Image, Name, Brand, Info)
                  CustomCartItem(
                    cartItem: item,
                  ),
                  if (showAddRemoveButtons)
                    const SizedBox(
                      height: ConstantSizes.spaceBtwItems,
                    ),

                  // Add and Remove With Total Price
                  if (showAddRemoveButtons)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Extra Space
                            const SizedBox(
                              width: 70,
                            ),
                            // Buttons (Add, Remove)
                            CustomProductQuantityAddRemoveButton(
                              quantity: item.quantity,
                              onAdd: () => controller.addOneItemToCart(item),
                              onRemove: () =>
                                  controller.removeOneItemFromCart(item),
                            ),
                          ],
                        ),
                        CustomProductPriceText(
                          price:
                              (item.price * item.quantity).toStringAsFixed(1),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
