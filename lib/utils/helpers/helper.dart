import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';

class HelperFunctions {
  static Map<String, dynamic>? getColor(String value) {
    if (value == 'Black Grey Gum') {
      return {
        'gradient': const LinearGradient(
          colors: [Colors.black, Colors.grey],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      };
    } else if (value == 'Desert Gold') {
      return {'color': const Color(0xFFB88E56)};
    } else if (value == 'Silver Graphite') {
      return {'color': const Color(0xFFE5E4E2)};
    } else if (value == 'White Ceramic') {
      return {'color': ConstantColors.softGrey};
    } else if (value == 'Pale Ivor/Light Orewood Brown') {
      return {
        'gradient': const LinearGradient(
          colors: [
            Color(0xFFC3B091),
            Color(0xFFFAF0E6),
          ],
        ),
      };
    } else if (value == 'Red/Black') {
      return {
        'gradient': const LinearGradient(
          colors: [Colors.red, Colors.black],
        ),
      };
    } else if (value == 'Green/Black') {
      return {
        'gradient': const LinearGradient(
          colors: [
            Color(0xFF013220),
            Colors.black,
          ],
        ),
      };
    } else if (value == 'Grey') {
      return {'color': Colors.grey};
    } else if (value == 'Black Titanium') {
      return {'color': Colors.black};
    } else if (value == 'Black') {
      return {'color': Colors.black};
    } else if (value == 'White') {
      return {'color': Colors.white};
    } else if (value == 'Retro SE') {
      return {
        'gradient': const LinearGradient(
          colors: [
            Color(0xFFC1E1C1),
            Color.fromARGB(255, 135, 168, 135),
          ],
        ),
      };
    } else if (value == 'Black / Graphite / White - 001') {
      return {
        'gradient': const LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Colors.grey,
            Colors.white,
          ],
        ),
      };
    } else if (value == 'Royal / Graphite / White - 400') {
      return {
        'gradient': const LinearGradient(
          colors: [
            Color.fromARGB(255, 28, 111, 255),
            Colors.grey,
            Colors.white,
          ],
        ),
      };
    } else if (value == 'Midnight Navy / Graphite / White - 410') {
      return {
        'gradient': const LinearGradient(
          colors: [
            Color.fromARGB(255, 27, 58, 112),
            Colors.grey,
            Colors.white,
          ],
        ),
      };
    } else if (value == 'Red / Graphite / White - 600') {
      return {
        'gradient': const LinearGradient(
          colors: [
            Colors.red,
            Colors.grey,
            Colors.white,
          ],
        ),
      };
    } else if (value == 'Denim Turquoise') {
      return {
        'gradient': const LinearGradient(
          colors: [
            Color.fromARGB(255, 6, 161, 172),
            Color(0xFFDFFF00),
          ],
        ),
      };
    } else if (value == 'Light Orewood Brown') {
      return {
        'gradient': const LinearGradient(
          colors: [
            Color(0xFFC4A484),
            Color.fromARGB(255, 253, 60, 1),
          ],
        ),
      };
    } else if (value == 'Cyan') {
      return {'color': const Color.fromARGB(255, 1, 255, 230)};
    } else if (value == 'Indigo') {
      return {'color': Colors.indigo};
    } else if (value == 'Silver') {
      return {'color': Colors.grey};
    } else {
      return null;
    }
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}
