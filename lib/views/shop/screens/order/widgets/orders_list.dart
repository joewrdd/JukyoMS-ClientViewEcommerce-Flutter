import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/rounded_container.dart';
import 'package:jukyo_ms/navigation.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/cloud.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/utils/loaders/animation.dart';
import 'package:jukyo_ms/views/shop/controllers/order_controller.dart';

class CustomOrderListItems extends StatelessWidget {
  const CustomOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = HelperFunctions.isDarkMode(context);
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        final widget = AnimationLoaderWidget(
          text: 'Whoops! No Orders Yet!',
          animation: ConstantImages.emptyOrder,
          animationType: AnimationType.gif,
          showAction: true,
          actionText: "Go Add Some...",
          onActionPressed: () => Get.off(() => NavigationMenu()),
        );

        final response = CloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot, nothingFound: widget);
        if (response != null) return response;

        final orders = snapshot.data!;
        return ListView.separated(
          separatorBuilder: (ctx, index) => const SizedBox(
            height: ConstantSizes.spaceBtwItems,
          ),
          itemCount: orders.length,
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            final order = orders[index];
            return CustomRoundedContainer(
              showBorder: true,
              padding: EdgeInsets.all(ConstantSizes.md),
              backgroundColor:
                  dark ? ConstantColors.dark : ConstantColors.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ROW 1
                  Row(
                    children: [
                      // Icon 1
                      Icon(
                        Iconsax.ship,
                      ),
                      const SizedBox(
                        width: ConstantSizes.spaceBtwItems / 2,
                      ),
                      // Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.apply(
                                        color: dark
                                            ? ConstantColors.buttonSecondary
                                            : ConstantColors.primary,
                                        fontWeightDelta: 1,
                                      ),
                            ),
                            Text(
                              order.formattedOrderDate,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                      // Icon 2
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Iconsax.arrow_right_34,
                          size: ConstantSizes.iconSm,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: ConstantSizes.spaceBtwItems,
                  ),
                  // ROW 2
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            // Icon 3
                            Icon(
                              Iconsax.tag,
                            ),
                            const SizedBox(
                              width: ConstantSizes.spaceBtwItems / 2,
                            ),
                            // Order & Order Number
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.id,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            // Icon 4
                            Icon(
                              Iconsax.calendar,
                            ),
                            const SizedBox(
                              width: ConstantSizes.spaceBtwItems / 2,
                            ),
                            // Order & Order Number
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipping Date',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.formattedDeliveryDate,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
