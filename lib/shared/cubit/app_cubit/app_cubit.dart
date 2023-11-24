import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/get_favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/setting_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_status.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../models/categories_model.dart';
import '../../../models/favorites_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
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

  Map<int, bool> favorites = {};
  HomeModel? homeModel;

  void getHomeData() {
    emit(AppHomeLodingState());
    DioHelper.getData(
      url: HOME,
      token: token,
      lang: 'en',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
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
    }).catchError((error) {
      print("error when get cat" + error.toString());
      emit(AppCategoriesErrorState());
    });
  }

  FavorittesModel? favoritesModel;
  void changeFavoritesIcon(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(AppChangeFavoriteState());

    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {
          'product_id': productId,
        }
    ).then((value) {
      favoritesModel = FavorittesModel.fromJson(value.data);
      if (favoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      }
      getFavoritesData();
      emit(AppChangeFavoriteSuccessState(favoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(AppChangeFavoriteErrorState());
      print(error.toString());
    });
  }

  GetFavorites? getFavorites;
  void getFavoritesData() {
    emit(AppLodingGetFavoriteState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
      lang: 'en',
    ).then((value){
      getFavorites = GetFavorites.fromJson(value.data);
      emit(AppGetFavoriteSuccessState());
    }).catchError((error) {
      print("error when get favorite" + error.toString());
      emit(AppGetFavoriteErrorState());
    });
  }

  LoginModel? userModel;
  void getUserData() {
    emit(AppLodingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
      lang: 'en',
    ).then((value){
      userModel= LoginModel.fromJson(value.data);
      print(userModel!.data!.phone);
      emit(AppUserDataSuccessState());
    }).catchError((error) {
      print("error when get user data" + error.toString());
      emit(AppUserDataErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
}) {
    emit(AppLodingUpdateUserDataState());
    DioHelper.putData(
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      url: UPDATE_PROFILE,
      token: token,
      lang: 'en',
    ).then((value){
      userModel= LoginModel.fromJson(value.data);
      print(userModel!.data!.phone);
      emit(AppUpdateUserDataSuccessState());
    }).catchError((error) {
      print("error when get update user data" + error.toString());
      emit(AppUpdateUserDataErrorState());
    });
  }




}
