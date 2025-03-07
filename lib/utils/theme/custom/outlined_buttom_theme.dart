import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class CustomOutlinedButtonTheme {
  CustomOutlinedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: ConstantColors.dark,
      side: const BorderSide(color: ConstantColors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16,
          color: ConstantColors.black,
          fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: ConstantSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ConstantColors.light,
      side: const BorderSide(color: ConstantColors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16,
          color: ConstantColors.textWhite,
          fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: ConstantSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantSizes.buttonRadius)),
    ),
  );
}
