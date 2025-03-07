import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: ConstantColors.light,
      backgroundColor: ConstantColors.primary,
      disabledForegroundColor: ConstantColors.darkGrey,
      disabledBackgroundColor: ConstantColors.buttonDisabled,
      side: const BorderSide(color: ConstantColors.primary),
      padding: const EdgeInsets.symmetric(vertical: ConstantSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16,
          color: ConstantColors.textWhite,
          fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: ConstantColors.light,
      backgroundColor: ConstantColors.primary,
      disabledForegroundColor: ConstantColors.darkGrey,
      disabledBackgroundColor: ConstantColors.darkerGrey,
      side: const BorderSide(color: ConstantColors.primary),
      padding: const EdgeInsets.symmetric(vertical: ConstantSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16,
          color: ConstantColors.textWhite,
          fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantSizes.buttonRadius)),
    ),
  );
}
