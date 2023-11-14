import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0.0,

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    color: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 8.0,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed
  ),
  textTheme: TextTheme(),
  fontFamily:'Janna',

);