import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DeviceUtils {
  // Hides the keyboard by removing focus from any text field
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // Sets the status bar color
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  // Checks if the device is in landscape orientation
  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  // Checks if the device is in portrait orientation
  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  // Enables or disables full-screen mode
  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  // Returns the screen height of the device
  static double getScreenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  // Returns the screen width of the device
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Returns the device's pixel ratio
  static double getPixelRatio() {
    return MediaQuery.of(Get.context!).devicePixelRatio;
  }

  // Returns the height of the status bar
  static double getStatusBarHeight() {
    return MediaQuery.of(Get.context!).padding.top;
  }

  // Returns the default height of the bottom navigation bar
  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  // Returns the default height of the app bar
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  // Returns the height of the on-screen keyboard
  static double getKeyboardHeight() {
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    return viewInsets.bottom;
  }

  // Checks if the keyboard is currently visible
  static Future<bool> isKeyboardVisible() async {
    final viewInsets = View.of(Get.context!).viewInsets;
    return viewInsets.bottom > 0;
  }

  // Determines if the app is running on a physical device
  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  // Triggers a vibration for the given duration
  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  // Sets the preferred screen orientations
  static Future<void> setPreferredOrientations(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  // Hides the status bar
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  // Shows the status bar
  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  // Checks for an active internet connection
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // Checks if the device is running iOS
  static bool isIOS() {
    return Platform.isIOS;
  }

  // Checks if the device is running Android
  static bool isAndroid() {
    return Platform.isAndroid;
  }

  // Launches a given URL in the default browser
  static void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could Not Launch $url';
    }
  }

  // Dialog For Platform
  static Future<ImageSource?> selectImageSource(BuildContext context) async {
    final dark = HelperFunctions.isDarkMode(context);
    if (Platform.isIOS) {
      // iOS CupertinoActionSheet
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: const Text('Select Image Source'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              child: Text(
                'Gallery',
                style: TextStyle(
                    color: dark
                        ? ConstantColors.buttonSecondary
                        : ConstantColors.black),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              child: Text(
                'Camera',
                style: TextStyle(
                    color: dark
                        ? ConstantColors.buttonSecondary
                        : ConstantColors.black),
              ),
            ),
          ],
        ),
      );
    } else {
      // Android AlertDialog
      return showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              child: Text(
                'Gallery',
                style: TextStyle(
                    color: dark
                        ? ConstantColors.buttonSecondary
                        : ConstantColors.black),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              child: Text(
                'Camera',
                style: TextStyle(
                    color: dark
                        ? ConstantColors.buttonSecondary
                        : ConstantColors.black),
              ),
            ),
          ],
        ),
      );
    }
  }
}
