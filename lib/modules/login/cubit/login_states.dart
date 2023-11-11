import 'package:shop_app/models/login_model.dart';

abstract class LoginStates{}

class LoginInitialStates extends LoginStates{}

class LoginSuccessStates extends LoginStates{
  final LoginModel loginModel;
  LoginSuccessStates(this.loginModel);
}

class LoginLodingStates extends LoginStates{}

class LoginErrorStates extends LoginStates{
  final String error;
  LoginErrorStates(this.error);
}

class LoginChangeVisibilityStates extends LoginStates{}

