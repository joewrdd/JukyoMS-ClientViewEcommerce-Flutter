import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/data/repos/authentication/auth_repo.dart';
import 'package:jukyo_ms/data/repos/user/user_repository.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/helpers/network_manager.dart';
import 'package:jukyo_ms/utils/popups/fullscreen_loader.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/auth/models/user_model.dart';
import 'package:jukyo_ms/views/auth/screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs; // Observable For Hiding/Showing Password
  final firstName = TextEditingController();
  final phoneNb = TextEditingController();
  final privacyPolicy = true.obs; // Observable For Checking/UnChecking TOS
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // SignUp
  void signup() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', ConstantImages.signInLoader);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        Loaders.warningSnackBar(
          title: 'Accept Privacy Policy!',
          message:
              'In order to successfully create your account, you must accept the Privacy Policy & Terms Of Use.',
        );
        return;
      }

      // Register User In The Firebase Auth & Save User Data
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated User Data In The Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNb: phoneNb.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(
          title: 'Congrats',
          message:
              'Your account has beem created! Verify your email to continue.');

      // Move To Verify Email Screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Some Generic Error To User
      Loaders.errorSnackBar(
          title: 'Oh Snap... An Error Has Occured!', message: e.toString());
    }
  }
}
