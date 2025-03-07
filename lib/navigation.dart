import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/personalization/screens/settings/settings.dart';
import 'package:jukyo_ms/views/shop/screens/home/home.dart';
import 'package:jukyo_ms/views/shop/screens/store/store.dart';
import 'package:jukyo_ms/views/shop/screens/wishlist/wishlist.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      // Observe The Navigation Controller
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: dark
                  ? const Color.fromARGB(255, 188, 227, 234).withOpacity(0.15)
                  : const Color.fromARGB(255, 54, 77, 93).withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, -10),
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Obx(
            () => NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: Colors.transparent,
                backgroundColor: dark ? ConstantColors.black : Colors.white,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return TextStyle(
                        fontSize: 13,
                        color: dark
                            ? const Color.fromARGB(255, 188, 227, 234)
                            : const Color.fromARGB(255, 54, 77, 93),
                      );
                    }
                    return TextStyle(color: dark ? Colors.white : Colors.black);
                  },
                ),
              ),
              child: NavigationBar(
                height: 65,
                elevation: 0,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (value) {
                  controller.selectedIndex.value = value;
                },
                destinations: [
                  NavigationDestination(
                    icon: Icon(Iconsax.house_2),
                    label: 'Home',
                    selectedIcon: Icon(
                      Iconsax.house_2,
                      color: dark
                          ? const Color.fromARGB(255, 188, 227, 234)
                          : const Color.fromARGB(255, 54, 77, 93),
                    ),
                  ),
                  NavigationDestination(
                    icon: Icon(Iconsax.shop_add4),
                    label: 'Store',
                    selectedIcon: Icon(
                      Iconsax.shop_add4,
                      color: dark
                          ? const Color.fromARGB(255, 188, 227, 234)
                          : const Color.fromARGB(255, 54, 77, 93),
                    ),
                  ),
                  NavigationDestination(
                    icon: Icon(Iconsax.medal_star),
                    label: 'Wishlist',
                    selectedIcon: Icon(
                      Iconsax.medal_star,
                      color: dark
                          ? const Color.fromARGB(255, 188, 227, 234)
                          : const Color.fromARGB(255, 54, 77, 93),
                    ),
                  ),
                  NavigationDestination(
                    icon: Icon(Iconsax.profile_circle),
                    label: 'Profile',
                    selectedIcon: Icon(
                      Iconsax.profile_circle,
                      color: dark
                          ? const Color.fromARGB(255, 188, 227, 234)
                          : const Color.fromARGB(255, 54, 77, 93),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  // Observor
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const WishlistScreen(),
    const SettingsScreen(),
  ];
}
