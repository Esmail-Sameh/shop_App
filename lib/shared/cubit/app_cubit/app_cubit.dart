import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/setting_screen.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_status.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens =[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Products',
    'Categories',
    'Favorites',
    'Settings',
  ];


  void changeBouttonNav (int index){
    this.currentIndex = index;
    emit(AppChangeButtonNavStates());
  }

}