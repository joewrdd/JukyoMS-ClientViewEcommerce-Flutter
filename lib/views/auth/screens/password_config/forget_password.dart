import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/constants/texts.dart';
import 'package:jukyo_ms/utils/validators/validation.dart';
import 'package:jukyo_ms/views/auth/controllers/forget_password/forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ConstantSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Headings
              Text(
                ConstantTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              Text(
                ConstantTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwSections * 2,
              ),
              // Text Field
              Form(
                key: controller.forgetPasswordFormKey,
                child: TextFormField(
                  controller: controller.email,
                  validator: Validator.validateEmail,
                  decoration: InputDecoration(
                    labelText: ConstantTexts.email,
                    prefixIcon: Icon(
                      Iconsax.direct_right,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwSections,
              ),
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.sendPasswordResetEmail(),
                  child: const Text(
                    ConstantTexts.submit,
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
