import 'package:flutter/material.dart';
import 'package:sell_point/core/constants/colors.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: SellPointColors.main,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: SellPointColors.backgroundWhite,
  textTheme: TextTheme(titleLarge: TextStyle(color: SellPointColors.main)),
  primaryColor: SellPointColors.main,
  inputDecorationTheme: InputDecorationTheme(
    focusColor: SellPointColors.lightGray,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2),
    ),
  ),
);
