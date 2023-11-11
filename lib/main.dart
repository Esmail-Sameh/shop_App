import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/test.dart';
import '../modules/on_boarding/on_boarding_screen.dart';
import '../shared/styles/themes.dart';
import 'modules/login/cubit/observer.dart';
void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: OnBoardingScreen.routName,
      routes: {
        OnBoardingScreen.routName:(context) => OnBoardingScreen(),
        LoginScreen.routName:(context) => LoginScreen(),
        RegisterScreen.routName:(context) => RegisterScreen(),
        Test.routName: (context) => Test(),
      },
      theme: lightTheme,
    );
  }
}
