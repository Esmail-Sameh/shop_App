import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(): super(LoginInitialStates());

  static LoginCubit get(context)=> BlocProvider.of(context);

  void userLogin({
    required String user,
    required String password,
  }){
    emit(LoginLodingStates());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':user,
          'password':password,
        }
    ).then((value){
      print(value.data);
      emit(LoginSuccessStates());
    }).catchError((error){
      emit(LoginErrorStates(error.toString()));
      print(error);
    });
  }

}
