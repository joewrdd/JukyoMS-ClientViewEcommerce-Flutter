import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CustomChipTheme {
  CustomChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: ConstantColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: ConstantColors.black),
    selectedColor: ConstantColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: ConstantColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: ConstantColors.darkerGrey,
    labelStyle: TextStyle(color: ConstantColors.white),
    selectedColor: ConstantColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: ConstantColors.white,
  );
}
