import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/data/repos/authentication/auth_repo.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/helpers/network_manager.dart';
import 'package:jukyo_ms/utils/popups/fullscreen_loader.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/auth/screens/password_config/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Start Loader
      TFullScreenLoader.openLoadingDialog(
          'Processing Your Request...', ConstantImages.emailSupport);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Authentication Call To Send Email Resest Pass
      await AuthenticationRepository.instance
          .forgetPasswordResetEmail(email.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Screen
      Loaders.successSnackBar(
          title: 'Email Sent.',
          message: 'Email Link Sent To Reset Your Password'.tr);

      // ReDirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      // Start Loader
      TFullScreenLoader.openLoadingDialog(
          'Processing Your Request...', ConstantImages.emailSupport);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Authentication Call To Send Email Resest Pass
      await AuthenticationRepository.instance.forgetPasswordResetEmail(email);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Screen
      Loaders.successSnackBar(
          title: 'Email Sent.',
          message: 'Email Link Sent To Reset Your Password'.tr);
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
