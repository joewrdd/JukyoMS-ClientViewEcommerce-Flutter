import 'package:flutter/material.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/device/device_utility.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? ConstantColors.black : ConstantColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: ConstantColors.primary,
        labelColor: dark ? ConstantColors.white : ConstantColors.primary,
        unselectedLabelColor: ConstantColors.darkGrey,
        tabAlignment: TabAlignment.start,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}

// If you want to add a background color to tabs you have to wrap them in Material widget.

// To do that we need [PreferredSizeWidget] and that's why we created custom class.
