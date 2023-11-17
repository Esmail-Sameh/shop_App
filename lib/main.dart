import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/test.dart';
import '../modules/on_boarding/on_boarding_screen.dart';
import '../shared/styles/themes.dart';
import 'modules/login/cubit/observer.dart';
void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  //CacheHelper.saveData(key: 'onBoarding', value: false);
  bool? onboarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  Widget? widget;
  print(token);

  if(onboarding != null){
    if(token != null){
      widget = HomeLayoutScreen();
    }else{
      widget = LoginScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
   final Widget? startWidget;

   MyApp({
    super.key,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..getHomeData()..getCategoriesData()..getFavoritesData(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
        routes: {
          OnBoardingScreen.routName: (context) => OnBoardingScreen(),
          LoginScreen.routName: (context) => LoginScreen(),
          RegisterScreen.routName: (context) => RegisterScreen(),
          Test.routName: (context) => Test(),
          HomeLayoutScreen.routName: (context) => HomeLayoutScreen(),
          SearchScreen.routName: (context) => SearchScreen(),
        },
        theme: lightTheme,
      ),
    );
  }
}
