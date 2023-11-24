import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

String? token = '';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    navigatAndRemove(context, LoginScreen.routName);
  }).catchError((error) {
    print(error.toString());
  });
}