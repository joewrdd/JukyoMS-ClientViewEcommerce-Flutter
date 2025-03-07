import 'package:flutter/material.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';

class SpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: ConstantSizes.appBarHeight,
    left: ConstantSizes.defaultSpace,
    bottom: ConstantSizes.defaultSpace,
    right: ConstantSizes.defaultSpace,
  );
}
