import 'package:social_media_task_bloc_project/app/common/app_errors.dart';

class CustomValidtion {
  static String? isEmail(String? email) {
    const emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final isMatch = RegExp(emailPattern).hasMatch(email ?? '');
    if (email == null || email.isEmpty) {
      return AppErrors.fieldIsRequired;
    } else if (isMatch == false) {
      return AppErrors.emailErrorText;
    } else {
      return null;
    }
  }

  static String? isPassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppErrors.fieldIsRequired;
    } else if (password.length < 8) {
      return AppErrors.passwordErrorText;
    } else {
      return null;
    }
  }
}
