import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import '../modules/on_boarding/on_boarding_screen.dart';
import '../shared/styles/themes.dart';
import 'modules/login/cubit/observer.dart';
void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routName,
      routes: {
        OnBoardingScreen.routName:(context) => OnBoardingScreen(),
        LoginScreen.routName:(context) => LoginScreen(),
        RegisterScreen.routName:(context) => RegisterScreen(),
      },
      theme: lightTheme,
    );
  }
}
