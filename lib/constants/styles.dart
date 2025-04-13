import 'package:flutter/material.dart';
import 'package:newsarticle/constants/colors.dart';
import 'package:newsarticle/constants/font_size.dart';
import 'package:newsarticle/constants/strings.dart';


class AppStyle {
  static const String fontFamily = Strings.interFontFamily;


  static final ThemeData appTheme = ThemeData(
    primaryColor: AppColor.primary,
    useMaterial3: true,
    primaryColorDark: AppColor.primaryDark,
    primarySwatch: AppColor.primaryColor,
    dividerColor: AppColor.divider,
    canvasColor: AppColor.white,
    indicatorColor: AppColor.primaryDark,
    iconTheme: const IconThemeData(
      color: AppColor.iconColor,
    ),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColor.primaryColor,
        selectionColor: AppColor.primaryColor.withValues(alpha:0.3),
        selectionHandleColor: AppColor.primaryColor),
    primaryIconTheme:
        const IconThemeData.fallback().copyWith(color: AppColor.black),
    //unselectedWidgetColor: AppColor.borderColor,
    appBarTheme: const AppBarTheme().copyWith(
      iconTheme: const IconThemeData(
        color: AppColor.white,
      ),
      titleSpacing: 0,
      centerTitle: false,
    ),

    radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.primary;
          } else {
            return AppColor.borderColor;
          }
        }),
        splashRadius: 3,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        visualDensity: VisualDensity.compact),

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: AppColor.primary),
    fontFamily: fontFamily,
    scaffoldBackgroundColor: AppColor.background,
  );
}

class AppTextStyle {
  static TextStyle bold = TextStyle(
      fontSize: AppFontSize.dp24,
      fontWeight: FontWeight.w700,
      color: AppColor.text);

  static TextStyle headerMedium = TextStyle(
      fontSize: AppFontSize.dp14,
      fontWeight: FontWeight.w700,
      color: AppColor.text);

  static TextStyle regular = TextStyle(
      fontSize: AppFontSize.dp20,
      fontWeight: FontWeight.w400,
      color: AppColor.text);

  static TextStyle medium = TextStyle(
    fontSize: AppFontSize.dp14,
    fontWeight: FontWeight.w500,
      color: AppColor.text
  );

  static TextStyle button = TextStyle(
      fontSize: AppFontSize.dp16,
      fontWeight: FontWeight.w700,
      color: AppColor.white);

  static TextStyle bodyRegular = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSize.dp14,
    color: AppColor.text,
  );

  static TextStyle hintTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSize.dp14,
    color: AppColor.hintTextColor,
  );

  static TextStyle breadCrumbUnSelect = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: AppFontSize.dp14,
    color: AppColor.white,
  );

  static TextStyle breadCrumbSelect = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: AppFontSize.dp14,
    color: AppColor.white,
  );

  static TextStyle navSelect = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: AppFontSize.dp10,
    color: AppColor.bottomBarIconColor,
  );
}
