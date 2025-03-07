import 'package:flutter/material.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import '../../constants/sizes.dart';

class CustomTextFormFieldTheme {
  CustomTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: ConstantColors.darkGrey,
    suffixIconColor: ConstantColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: ConstantSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
        fontSize: ConstantSizes.fontSizeMd, color: ConstantColors.black),
    hintStyle: const TextStyle().copyWith(
        fontSize: ConstantSizes.fonConstantSizesm, color: ConstantColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: ConstantColors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: ConstantColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: ConstantColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: ConstantColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: ConstantColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: ConstantColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: ConstantColors.darkGrey,
    suffixIconColor: ConstantColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: ConstantSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
        fontSize: ConstantSizes.fontSizeMd, color: ConstantColors.white),
    hintStyle: const TextStyle().copyWith(
        fontSize: ConstantSizes.fonConstantSizesm, color: ConstantColors.white),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: ConstantColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: ConstantColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: ConstantColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: ConstantColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: ConstantColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ConstantSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: ConstantColors.warning),
    ),
  );
}
