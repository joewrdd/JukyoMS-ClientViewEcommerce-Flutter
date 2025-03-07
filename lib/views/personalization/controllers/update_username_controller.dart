import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/data/repos/user/user_repository.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/helpers/network_manager.dart';
import 'package:jukyo_ms/utils/popups/fullscreen_loader.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/personalization/controllers/user_controller.dart';
import 'package:jukyo_ms/views/personalization/screens/profile/profile.dart';

class UpdateUsernameController extends GetxController {
  static UpdateUsernameController get instance => Get.find();

  final username = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUsernameFormKey = GlobalKey<FormState>();

  // Init User Data When Home Screen Appears
  @override
  void onInit() {
    initializeUsername();
    super.onInit();
  }

  // Fetch User Record
  Future<void> initializeUsername() async {
    username.text = userController.user.value.username;
  }

  Future<void> updateFullName() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are updating your information, please wait...',
          ConstantImages.signInLoader);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUsernameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update User's First & Last Name In Firebase Firestore
      Map<String, dynamic> name = {
        'Username': username.text.trim(),
      };
      await userRepository.updateSingleField(name);

      // Update Rx User Value
      userController.user.value.username = username.text.trim();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(
          title: 'Change Success!', message: 'Your name has been updated.');

      // Move To Previous Screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
