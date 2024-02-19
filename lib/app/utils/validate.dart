import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

mixin Validate {
  late BuildContext _context;

  get getContext => _context;

  set setContext(BuildContext context) => _context = context;

  String? validateUsername(String username) {
    if (username.isEmpty) {
      return FlutterI18n.translate(_context, "auth.sign_up.username_empty");
    }
    return null;
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return FlutterI18n.translate(_context, "auth.sign_in.email_empty");
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return FlutterI18n.translate(_context, "auth.sign_in.email_invalid");
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return FlutterI18n.translate(_context, "auth.sign_in.password_empty");
    }
    return null;
  }

  String? validatePasswordStrength(String password) {
    if (password.isEmpty) {
      return FlutterI18n.translate(_context, "auth.sign_up.password_empty");
    } else if (password.length < 6) {
      return FlutterI18n.translate(_context, "auth.sign_up.passwords_least");
    }
    return null;
  }

  String? validateConfirmPassword(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return FlutterI18n.translate(
        _context,
        "auth.sign_up.confirm_password_empty",
      );
    } else if (confirmPassword != password) {
      return FlutterI18n.translate(
        _context,
        "auth.sign_up.confirm_password_not_match",
      );
    }
    return null;
  }
}
