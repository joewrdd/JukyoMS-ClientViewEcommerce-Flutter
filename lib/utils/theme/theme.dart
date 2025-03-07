import 'package:flutter/material.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/theme/custom/appbar_theme.dart';
import 'package:jukyo_ms/utils/theme/custom/bottom_sheet_theme.dart';
import 'package:jukyo_ms/utils/theme/custom/checkbox_theme.dart';
import 'package:jukyo_ms/utils/theme/custom/chip_theme.dart';
import 'package:jukyo_ms/utils/theme/custom/elevated_button_theme.dart';
import 'package:jukyo_ms/utils/theme/custom/outlined_buttom_theme.dart';
import 'package:jukyo_ms/utils/theme/custom/text_field_theme.dart';
import 'package:jukyo_ms/utils/theme/custom/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: ConstantColors.primary,
    scaffoldBackgroundColor: ConstantColors.white,
    textTheme: CustomTextTheme.lightTextTheme,
    chipTheme: CustomChipTheme.lightChipTheme,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    checkboxTheme: CustomCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.lightInputDecorationTheme,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.black.withOpacity(0.5),
        cursorColor: ConstantColors.dark,
        selectionHandleColor: Colors.transparent),
  );
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: ConstantColors.primary,
    scaffoldBackgroundColor: ConstantColors.black,
    textTheme: CustomTextTheme.darkTextTheme,
    chipTheme: CustomChipTheme.darkChipTheme,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    checkboxTheme: CustomCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.darkInputDecorationTheme,
  );
}
