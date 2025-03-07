import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/constants/texts.dart';
import 'package:jukyo_ms/utils/device/device_utility.dart';
import 'package:jukyo_ms/views/auth/controllers/onboarding/onboarding_controller.dart';
import 'package:jukyo_ms/views/auth/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:jukyo_ms/views/auth/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:jukyo_ms/views/auth/screens/onboarding/widgets/onboarding_page.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: ConstantImages.onBoardingImage1,
                title: ConstantTexts.onBoardingTitle1,
                subTitle: ConstantTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: ConstantImages.onBoardingImage2,
                title: ConstantTexts.onBoardingTitle2,
                subTitle: ConstantTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: ConstantImages.onBoardingImage3,
                title: ConstantTexts.onBoardingTitle3,
                subTitle: ConstantTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          Positioned(
            top: DeviceUtils.getAppBarHeight(),
            right: ConstantSizes.defaultSpace,
            child: TextButton(
              onPressed: () => OnBoardingController.instance.skipPage(),
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: ConstantColors.primary,
                ),
              ),
            ),
          ),
          OnBoardingDotNavigation(),
          OnBoardingNextButton(),
        ],
      ),
    );
  }
}
