import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/constants/texts.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/views/auth/controllers/forget_password/forget_password_controller.dart';
import 'package:jukyo_ms/views/auth/screens/login/login.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              CupertinoIcons.clear,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            ConstantSizes.defaultSpace,
          ),
          child: Column(
            children: [
              // Image with 60% Screen Width
              Image(
                image: AssetImage(ConstantImages.deliveredEmailIllustration),
                width: HelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              // Title & SubTitle
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              Text(
                ConstantTexts.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              Text(
                ConstantTexts.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwSections,
              ),
              // Done Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: const Text(ConstantTexts.done),
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              // Re-Send Email Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.resendPasswordResetEmail(email),
                  child: const Text(
                    ConstantTexts.resendEmail,
                    style: TextStyle(color: ConstantColors.buttonPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
