import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jukyo_ms/common/widgets/chips/choice_chip.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/rounded_container.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/product_price_text.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/product_title_text.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/shop/controllers/products/variation_controller.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class CustomProductAttributes extends StatelessWidget {
  const CustomProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () {
        return Column(
          children: [
            // Selected Attribute Pricing & Description
            if (controller.selectedVariation.value.id.isNotEmpty)
              CustomRoundedContainer(
                padding: EdgeInsets.all(ConstantSizes.md),
                backgroundColor:
                    dark ? ConstantColors.darkerGrey : ConstantColors.grey,
                child: Column(
                  children: [
                    // Title, Price and Stock Status
                    Row(
                      children: [
                        const CustomSectionHeader(
                          title: 'Variations',
                          showActionButton: false,
                        ),
                        const SizedBox(
                          width: ConstantSizes.spaceBtwItems,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CustomProductTitleText(
                                  title: 'Price: ',
                                  smallSize: true,
                                ),
                                // Sale Price
                                CustomProductPriceText(
                                  price: controller.getVariationPrice(),
                                ),
                                const SizedBox(
                                  width: ConstantSizes.spaceBtwItems,
                                ),
                                // Actual Price
                                if (controller
                                        .selectedVariation.value.salePrice >
                                    0)
                                  Text(
                                    '\$${controller.selectedVariation.value.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .apply(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontFamily:
                                              GoogleFonts.barlow().fontFamily,
                                        ),
                                  ),
                                const SizedBox(
                                  width: ConstantSizes.spaceBtwItems,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: ConstantSizes.sm / 2,
                            ),

                            // Stock
                            Row(
                              children: [
                                const CustomProductTitleText(
                                  title: 'Stock: ',
                                  smallSize: true,
                                ),
                                Text(
                                  controller.selectedStockStatus.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .apply(
                                          color: controller.selectedStockStatus
                                                      .value ==
                                                  'Available'
                                              ? ConstantColors.success
                                              : ConstantColors.error),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (controller
                        .selectedVariation.value.description!.isNotEmpty)
                      // Variation Description
                      CustomProductTitleText(
                        title: controller.selectedVariation.value.description ??
                            '',
                        smallSize: true,
                        maxLines: 4,
                      ),
                  ],
                ),
              ),
            const SizedBox(
              height: ConstantSizes.spaceBtwItems,
            ),
            // Attributes
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: product.productAttributes!
                  .map(
                    (attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSectionHeader(
                          title: attribute.name ?? '',
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: ConstantSizes.spaceBtwItems / 2,
                        ),
                        Obx(() {
                          return Wrap(
                            spacing: 8,
                            children: attribute.values!.map((value) {
                              final isSelected = controller
                                      .selectedAttributes[attribute.name] ==
                                  value;
                              final isAvailable = controller
                                  .getAttributesAvailabilityInVariation(
                                      product.productVariations!,
                                      attribute.name!)
                                  .contains(value);
                              return Column(
                                children: [
                                  CustomChoiceChip(
                                    text: value,
                                    selected: isSelected,
                                    onSelected: (isAvailable)
                                        ? (selected) {
                                            if (selected && isAvailable) {
                                              controller.onAttributeSelected(
                                                  product,
                                                  attribute.name ?? '',
                                                  value);
                                            }
                                          }
                                        : null,
                                  ),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwItems,
                                  ),
                                ],
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
