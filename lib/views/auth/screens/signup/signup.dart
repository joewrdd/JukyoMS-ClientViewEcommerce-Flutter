import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:jukyo_ms/common/widgets/login_signup/form_divider.dart';
import 'package:jukyo_ms/common/widgets/login_signup/social_buttons.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/constants/texts.dart';
import 'package:jukyo_ms/views/auth/screens/signup/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            ConstantSizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                ConstantTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwSections,
              ),
              // Form
              SignUpForm(),
              const SizedBox(
                height: ConstantSizes.spaceBtwSections,
              ),
              // Divider
              FormDivider(
                dividerText: ConstantTexts.orSignUpWith.capitalize!,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwSections,
              ),
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
