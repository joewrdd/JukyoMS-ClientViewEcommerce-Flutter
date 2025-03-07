import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/login_signup/form_divider.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/constants/texts.dart';
import 'package:jukyo_ms/views/auth/screens/login/widgets/login_form.dart';
import 'package:jukyo_ms/views/auth/screens/login/widgets/login_header.dart';
import 'package:jukyo_ms/common/widgets/login_signup/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: ConstantSizes.appBarHeight,
            left: ConstantSizes.defaultSpace,
            bottom: ConstantSizes.defaultSpace,
            right: ConstantSizes.defaultSpace,
          ),
          child: Column(
            children: [
              LoginHeader(),
              // LOGIN FORM
              LoginForm(),
              // DIVIDER
              FormDivider(
                dividerText: ConstantTexts.orSignInWith.capitalize!,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwSections,
              ),
              // FOOTER
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
