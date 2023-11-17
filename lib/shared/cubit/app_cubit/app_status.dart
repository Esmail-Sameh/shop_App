import 'package:shop_app/models/favorites_model.dart';

abstract class AppStates {}

class AppInitialStates extends AppStates{}

class AppChangeButtonNavStates extends AppStates{}

class AppHomeLodingState extends AppStates{}

class AppHomeSuccessState extends AppStates{}

class AppHomeErrorState extends AppStates{}

class AppCategoriesLodingState extends AppStates{}

class AppCategoriesSuccessState extends AppStates{}

class AppCategoriesErrorState extends AppStates{}

class AppChangeFavoriteState extends AppStates{}

class AppChangeFavoriteSuccessState extends AppStates{
  final FavorittesModel model;
  AppChangeFavoriteSuccessState(this.model);
}

class AppChangeFavoriteErrorState extends AppStates{}

class AppLodingGetFavoriteState extends AppStates{}

class AppGetFavoriteSuccessState extends AppStates{}

class AppGetFavoriteErrorState extends AppStates{}
