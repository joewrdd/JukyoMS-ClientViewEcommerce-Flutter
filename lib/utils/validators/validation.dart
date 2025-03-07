class Validator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName Is Required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email Is Required.';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid Email Address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password Is Required.';
    }

    if (value.length < 6) {
      return 'Password Must Be At Least 6 Characters Long.';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password Must Contain At Least One Uppercase Letter.';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password Must Contain At Least One Number.';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password Must Contain At Least One Special Character.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number Is Required.';
    }

    final phoneRegExp = RegExp(r'^\d{8}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid Phone Number Format (8 digits required).';
    }

    return null;
  }
}
