import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import '../../shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  static String routName = 'loginScreen';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit , LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  key: formKey,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'login now to browse our hot offers',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultTextFile(
                      lable: 'Email Address',
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Please enter your email address';
                        }
                      },
                      prefixIcon: Icons.email_outlined,
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFile(
                      lable: 'Password',
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Password is too short';
                        }
                      },
                      prefixIcon: Icons.lock_outline,
                      controller: passwordController,
                      inputType: TextInputType.visiblePassword,
                      suffixIcon: Icons.visibility_off,
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: state is! LoginLodingStates,
                      builder:(context) => defaultButton(
                        onPressed: () {
                          // if(formKey.currentState!.validate()){
                          //   LoginCubit.get(context).userLogin(
                          //     user: emailController.text,
                          //     password: passwordController.text,
                          //   );
                          // }


                          LoginCubit.get(context).userLogin(
                              user: emailController.text,
                              password: passwordController.text,
                          );
                        },
                        text: 'LOGIN',
                      ),
                      fallback: (context) => Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        //SizedBox(width: 5,),
                        defaultTextButton(
                            onPressed: () {
                              navigatTo(context, RegisterScreen.routName);
                            },
                            text: 'register'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
