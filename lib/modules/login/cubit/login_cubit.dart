import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
    required String user,
    required String password,
    String? lang,
    String? token,
  }) {
    emit(LoginLodingStates());
    DioHelper.postData(url: LOGIN, data: {
      'email': user,
      'password': password,
      'lang': lang,
      'Authorization': token,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessStates(loginModel!));
    }).catchError((error) {
      emit(LoginErrorStates(error.toString()));
      print(error);
    });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangeVisibilityStates());
  }
}
