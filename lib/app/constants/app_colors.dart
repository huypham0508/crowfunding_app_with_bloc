import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppColors {
  static const Color primary600 = Color(0xff1DC071);
  static const Color primary500 = Color(0xff4ACD8D);
  static const Color primary400 = Color(0xff77D9AA);
  static const Color primary300 = Color(0xffA5E6C6);
  static const Color primary200 = Color(0xffD2F2E3);
  static const Color primary100 = Color(0xffF1FBF7);

  static const Color secondary500 = Color(0xff6F49FD);
  static const Color secondary400 = Color(0xff8C6DFD);
  static const Color secondary300 = Color(0xffA992FE);
  static const Color secondary200 = Color(0xffC5B6FE);
  static const Color secondary100 = Color(0xffE2DBFF);

  static const Color black500 = Color(0xff13131A);
  static const Color black400 = Color(0xff1C1C24);
  static const Color black300 = Color(0xff22222C);
  static const Color black200 = Color(0xff24242C);
  static const Color black100 = Color(0xff3A3A43);

  static const Color neutral500 = Color(0xff171725);
  static const Color neutral400 = Color(0xff4B5264);
  static const Color neutral300 = Color(0xff808191);
  static const Color neutral200 = Color(0xffA2A2A8);
  static const Color neutral100 = Color(0xffB2B3BD);

  static const Color whitish100 = Color(0xffFFFFFF);
  static const Color whitish200 = Color(0xffFCFBFF);
  static const Color whitish300 = Color(0xffF2F2F2);
  static const Color whitish400 = Color(0xffFCFCFC);
  static const Color whitish500 = Color(0xffF1F1F3);
  static const Color whitish600 = Color(0xffFCFCFD);

  static const Color red500 = Color(0xffEB5757);

  static const Color transparent = Colors.transparent;

  static List<BoxShadow> shadowPrimary = [
    BoxShadow(
      color: black500.withOpacity(0.1),
      spreadRadius: 5,
      blurRadius: 25,
      offset: const Offset(0, 0), // changes position of shadow
    ),
  ];

  //================================================================
  // static const Color backgroundPrimary = whitish100;
  static Color backgroundPrimary(BuildContext context) {
    String? themeLocalStorage = context.read<LocalDataSource>().getThemeMode();
    bool isDark = themeLocalStorage == ThemeMode.dark.toString();
    print(themeLocalStorage);
    return isDark ? black500 : whitish100;
  }

  static const Color backgroundPrimary200 = neutral300;

  static const Color textPrimary = black500;
  static const Color textPrimary200 = neutral400;

  Future<bool> checkDarkTheme() async {
    return true;
  }
}
