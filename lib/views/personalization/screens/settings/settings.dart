import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/circular_container.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/curved_edges.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:jukyo_ms/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:jukyo_ms/data/repos/authentication/auth_repo.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/personalization/screens/address/address.dart';
import 'package:jukyo_ms/views/personalization/screens/profile/profile.dart';
import 'package:jukyo_ms/views/personalization/screens/settings/widgets/load_data.dart';
import 'package:jukyo_ms/views/shop/screens/cart/cart.dart';
import 'package:jukyo_ms/views/shop/screens/order/orders.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            ClipPath(
              clipper: CustomCurvedEdges(),
              child: Container(
                color: ConstantColors.primary,
                padding: const EdgeInsets.all(0),
                child: Stack(
                  children: [
                    Positioned(
                      top: -150,
                      right: -250,
                      child: CustomCircularContainer(
                        backgroundColor:
                            ConstantColors.buttonSecondary.withOpacity(0.4),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      right: -300,
                      child: CustomCircularContainer(
                        backgroundColor:
                            ConstantColors.buttonSecondary.withOpacity(0.4),
                      ),
                    ),
                    // child
                    Column(
                      children: [
                        CustomAppBar(
                          title: Text(
                            'Account',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: ConstantColors.white),
                          ),
                        ),
                        const SizedBox(
                          height: ConstantSizes.spaceBtwSections,
                        ),
                        // User Profile Card
                        CustomUserProfileTile(
                          onPressed: () => Get.to(
                            () => const ProfileScreen(),
                          ),
                        ),
                        const SizedBox(
                          height: ConstantSizes.spaceBtwSections,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.all(
                ConstantSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  // Account Settings
                  CustomSectionHeader(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: ConstantSizes.spaceBtwItems,
                  ),
                  CustomSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delivery address',
                    onTap: () => Get.to(
                      () => const AddressScreen(),
                    ),
                  ),
                  CustomSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle:
                        'Add, remove and move products to and from checkout',
                    onTap: () => Get.to(
                      () => CartScreen(),
                    ),
                  ),
                  CustomSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed orders',
                    onTap: () => Get.to(
                      () => OrdersScreen(),
                    ),
                  ),
                  CustomSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subtitle: 'Withdraw balance to registered bank account',
                    onTap: () {},
                  ),
                  CustomSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subtitle: 'List of all the discounted coupons',
                    onTap: () {},
                  ),

                  CustomSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subtitle: 'Set any kind of notification message',
                    onTap: () {},
                  ),
                  CustomSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connected accounts',
                    onTap: () {},
                  ),

                  // App Settings
                  SizedBox(
                    height: ConstantSizes.spaceBtwSections,
                  ),
                  CustomSectionHeader(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: ConstantSizes.spaceBtwItems,
                  ),
                  CustomSettingsMenuTile(
                    onTap: () => Get.to(
                      () => const LoadDataScreen(),
                    ),
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subtitle: 'Upload your data to your own CloudFirebase',
                  ),
                  CustomSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subtitle: 'Set recommendation based on location',
                    trailing: Switch(
                      activeColor: dark
                          ? ConstantColors.buttonSecondary
                          : ConstantColors.buttonPrimary,
                      activeTrackColor: dark
                          ? ConstantColors.buttonSecondary.withOpacity(0.5)
                          : ConstantColors.primary.withOpacity(0.6),
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  CustomSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subtitle: 'Search result is safe for all ages',
                    trailing: Switch(
                      activeColor: ConstantColors.buttonPrimary,
                      activeTrackColor: ConstantColors.primary.withOpacity(0.6),
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  CustomSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subtitle: 'Set image quality to be seen',
                    trailing: Switch(
                      activeColor: ConstantColors.buttonPrimary,
                      activeTrackColor: ConstantColors.primary.withOpacity(0.6),
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  // LogOut Button
                  const SizedBox(
                    height: ConstantSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        await AuthenticationRepository.instance.logout();
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: ConstantSizes.spaceBtwSections * 2.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
