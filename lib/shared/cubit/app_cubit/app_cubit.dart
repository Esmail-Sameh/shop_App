import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/setting_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_status.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../models/categories_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  Map<int , bool> favorites = {};
  List<Widget> screens = [
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

  void changeBouttonNav(int index) {
    currentIndex = index;
    emit(AppChangeButtonNavStates());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(AppHomeLodingState());
    DioHelper.getData(
      url: HOME,
      token: token,
      lang: 'en',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
    //   homeModel!.data!.products.forEach((element) {
    //     favorites.addAll(
    //        : element.inFavorites;
    //     );
    // });

      emit(AppHomeSuccessState());
    }).catchError((error) {
      emit(AppHomeErrorState());
      print(error.toString());
    });
  }
  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: CATEGORIES,

    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(AppCategoriesSuccessState());
    }).catchError((error){
      print("error when get cat" + error.toString());
      emit(AppCategoriesErrorState());
    });
  }
}
