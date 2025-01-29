import 'package:crowfunding_app_with_bloc/src/constants/app_string.dart';

class ApiException implements Exception {
  @override
  String toString() {
    return CommonString.ERROR_MESSAGE;
  }
}
