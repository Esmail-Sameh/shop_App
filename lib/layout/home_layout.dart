import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class HomeLayoutScreen extends StatelessWidget {
  static String routName = 'homeLayoutScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
      ),
      body: defaultTextButton(
          onPressed: (){
            CacheHelper.removeData(key: 'token');
            navigatAndRemove(context, LoginScreen.routName);
          },
          text: 'signOut'
      ),
    );
  }
}
