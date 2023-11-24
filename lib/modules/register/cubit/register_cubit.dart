import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? registerModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? lang,
  }) {
    emit(RegisterLodingStates());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name' : name,
          'email': email,
          'password': password,
          'phone': phone,

        }).then((value) {
      registerModel = LoginModel.fromJson(value.data);
      print(registerModel!.status);
      emit(RegisterSuccessStates(registerModel!));
    }).catchError((error) {
      emit(RegisterErrorStates(error.toString()));

    });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangeVisibilityStates());
  }
}
