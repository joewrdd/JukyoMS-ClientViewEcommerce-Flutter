import 'package:flutter/material.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import '../../constants/colors.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme:
        IconThemeData(color: ConstantColors.black, size: ConstantSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: ConstantColors.black, size: ConstantSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: ConstantColors.black),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme:
        IconThemeData(color: ConstantColors.black, size: ConstantSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: ConstantColors.white, size: ConstantSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: ConstantColors.white),
  );
}
