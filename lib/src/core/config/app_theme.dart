import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/config/app_colors.dart';

class AppTheme {
  static final ThemeData dark = ThemeData(
    fontFamily: 'EuclidCircularB',
    appBarTheme: const AppBarTheme(
      color: AppColors.backgroundColor,
      titleTextStyle: TextStyle(
        color: AppColors.whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      centerTitle: true,
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.purpleColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              24,
            ),
            side: const BorderSide(
              color: AppColors.purpleColor,
            ),
          ),
        ),
      ),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: AppColors.whiteColor,

    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.lightBlueColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.greyColor,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.greyColor,
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.greyColor,
        ),
      ),
    ),
    focusColor: Colors.black,
    primaryColor: AppColors.purpleColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.purpleColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Colors.white, fontSize: 36, fontWeight: FontWeight.w500),
      displayMedium: TextStyle(
          color: Colors.white, fontSize: 34, fontWeight: FontWeight.w400),
      displaySmall: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 10,
          fontWeight: FontWeight.w500),
    ),
  );
}
