import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/success_screen/success.dart';
import 'package:jukyo_ms/data/repos/authentication/auth_repo.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/texts.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // Send Email Whenever Verify Screen Appears & Set Timer For Auto Redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // Send Email Verification Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(
          title: 'Email Sent!', message: "Check Your Inbox To Verify.");
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Timer To Auto Redirect On Email Verification
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              image: ConstantImages.successfullyRegisterAnimation,
              title: ConstantTexts.yourAccountCreatedTitle,
              subTitle: ConstantTexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ),
          ); // Off Destroys The Previous Screen So I Dont Go Back To It
        }
      },
    );
  }

  // Manually Check If Email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: ConstantImages.successfullyRegisterAnimation,
          title: ConstantTexts.yourAccountCreatedTitle,
          subTitle: ConstantTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
