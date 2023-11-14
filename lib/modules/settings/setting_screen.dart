import 'package:flutter/cupertino.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        defaultTextButton(
            onPressed: () {
              CacheHelper.removeData(key: 'token').then((value){
                navigatAndRemove(context, LoginScreen.routName);
              });
            },
            text: 'logout'
        ),
      ],
    );
  }
}
