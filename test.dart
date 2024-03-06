class AppColors {
  bool _isDark = false;

  set isDark(bool value) {
    _isDark = value;
  }

  bool get isDark => _isDark;

  String get string => isDark ? "dark" : "light";
}

void main() {
  AppColors appColors = AppColors();

  print(appColors.string);

  print(appColors.string);
  appColors.isDark = true;
}
