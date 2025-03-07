import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/constants/texts.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/utils/validators/validation.dart';
import 'package:jukyo_ms/views/auth/controllers/login/login_controller.dart';
import 'package:jukyo_ms/views/auth/screens/password_config/forget_password.dart';
import 'package:jukyo_ms/views/auth/screens/signup/signup.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = HelperFunctions.isDarkMode(context);
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: ConstantSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            // EMAIL
            TextFormField(
              controller: controller.email,
              validator: (value) => Validator.validateEmail(value),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Iconsax.direct_right,
                ),
                labelText: ConstantTexts.email,
              ),
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwInputFields,
            ),
            // PASSWORD
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    Validator.validateEmptyText("Password", value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: ConstantTexts.password,
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwInputFields / 2,
            ),
            // REMEMBER ME AND FORG PASSWORD
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Remember Me
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value,
                      ),
                    ),
                    const Text(
                      ConstantTexts.rememberMe,
                    ),
                  ],
                ),
                // Forget Password
                TextButton(
                  onPressed: () => Get.to(
                    () => const ForgetPasswordScreen(),
                  ),
                  child: const Text(
                    ConstantTexts.forgetPassword,
                    style: TextStyle(color: ConstantColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwSections,
            ),
            // SIGN IN BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: Text(
                  ConstantTexts.signIn,
                ),
              ),
            ),
            const SizedBox(
              height: ConstantSizes.spaceBtwItems,
            ),
            // CREATE ACCOUNT BUTTON
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: ButtonStyle(
                  side: WidgetStateProperty.all(
                    BorderSide(color: ConstantColors.buttonPrimary, width: 1),
                  ),
                ),
                onPressed: () => Get.to(
                  () => const SignUpScreen(),
                ),
                child: Text(
                  ConstantTexts.createAccount,
                  style: TextStyle(
                    color:
                        dark ? ConstantColors.white : ConstantColors.darkerGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
