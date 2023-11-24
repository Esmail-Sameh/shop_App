
import '../../../models/login_model.dart';

abstract class RegisterStates{}

class RegisterInitialStates extends RegisterStates{}

class RegisterSuccessStates extends RegisterStates{
  final LoginModel RegisterModel;
  RegisterSuccessStates(this.RegisterModel);
}

class RegisterLodingStates extends RegisterStates{}

class RegisterErrorStates extends RegisterStates{
  final String error;
  RegisterErrorStates(this.error);
}

class RegisterChangeVisibilityStates extends RegisterStates{}

