import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/constants/texts.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(
            dark ? ConstantImages.lightAppLogo : ConstantImages.darkAppLogo,
          ),
        ),
        Text(
          ConstantTexts.loginTitle,
          style: GoogleFonts.aDLaMDisplay(
            textStyle: Theme.of(context).textTheme.headlineLarge,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: ConstantSizes.sm,
        ),
        Text(ConstantTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
