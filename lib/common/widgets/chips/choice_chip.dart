import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/circular_container.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';

class CustomChoiceChip extends StatelessWidget {
  const CustomChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final dynamic color = HelperFunctions.getColor(text);
    return ChoiceChip(
      label: color != null
          ? SizedBox()
          : IntrinsicWidth(
              child: Container(
                height: 14,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: GoogleFonts.barlow(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: (selected ? ConstantColors.white : null)),
      avatar: color != null
          ? CustomCircularContainer(
              width: 45,
              height: 45,
              backgroundColor: color['gradient'] ?? color['color'],
            )
          : null,
      labelPadding: color != null ? const EdgeInsets.all(0) : null,
      padding: color != null ? const EdgeInsets.all(0) : null,
      shape: color != null ? const CircleBorder() : null,
      backgroundColor: dark
          ? (selected ? ConstantColors.primary : ConstantColors.dark)
          : (selected ? ConstantColors.primary : ConstantColors.white),
      side: BorderSide(
        color: dark
            ? (selected ? ConstantColors.primary : ConstantColors.white)
            : (selected ? ConstantColors.primary : ConstantColors.black),
        width: 1,
      ),
    );
  }
}
