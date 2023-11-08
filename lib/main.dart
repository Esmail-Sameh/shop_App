import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import '../modules/on_boarding/on_boarding_screen.dart';
import '../shared/styles/themes.dart';
void main (){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
      routes: {
        OnBoardingScreen.routName:(context) => OnBoardingScreen(),
        LoginScreen.routName:(context) => LoginScreen(),
      },
      theme: lightTheme,
    );
  }
}
