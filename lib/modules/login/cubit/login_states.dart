abstract class LoginStates{}

class LoginInitialStates extends LoginStates{}

class LoginSuccessStates extends LoginStates{}

class LoginLodingStates extends LoginStates{}

class LoginErrorStates extends LoginStates{
  final String error;
  LoginErrorStates(this.error);
}

class LoginChangeVisibilityStates extends LoginStates{}

