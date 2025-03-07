import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jukyo_ms/data/repos/authentication/auth_repo.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/helpers/network_manager.dart';
import 'package:jukyo_ms/utils/popups/fullscreen_loader.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/personalization/controllers/user_controller.dart';

class LoginController extends GetxController {
  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? '';
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? '';
  }

  // -- Email & Password Sign In
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging You In....', ConstantImages.signInLoader);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Data If RememberMe Is Selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login User Using Email & Pass Authentication
      // ignore: unused_local_variable
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // ReDirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // -- Google Sign In
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Google Login Loading...', ConstantImages.googleSignInLoader);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // If Null, User Cancelled The SignIn
      if (userCredentials == null) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save User Record Call
      final userSaved = await userController.saveUserRecord(userCredentials);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      if (userSaved) {
        // Only Redirect If User Data Was Saved Successfully
        await AuthenticationRepository.instance.screenRedirect();
      } else {
        // Handle The Case Where User Data Wasn't Saved
        Loaders.errorSnackBar(
            title: 'Error',
            message: 'Failed to save user data. Please try again.');
        // Optionally Logout The User If Data Saving Failed
        await AuthenticationRepository.instance.logout();
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
