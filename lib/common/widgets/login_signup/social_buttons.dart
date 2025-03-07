import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/auth/controllers/login/login_controller.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: dark ? ConstantColors.white : ConstantColors.buttonPrimary,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              width: ConstantSizes.iconMd,
              height: ConstantSizes.iconMd,
              image: AssetImage(ConstantImages.google),
            ),
          ),
        ),
        const SizedBox(
          width: ConstantSizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: dark ? ConstantColors.white : ConstantColors.buttonPrimary,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: ConstantSizes.iconMd,
              height: ConstantSizes.iconMd,
              image: AssetImage(ConstantImages.facebook),
            ),
          ),
        ),
      ],
    );
  }
}
