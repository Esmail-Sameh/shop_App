import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/register_cubit.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  static String routName = 'registerScreen';
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit , RegisterStates>(
          listener: (context, state) {
            if (state is RegisterSuccessStates) {
              if (state.RegisterModel.status == true) {
                CacheHelper.saveData(
                    key: 'token', value: state.RegisterModel.data!.token)
                    .then((value) {
                  token = state.RegisterModel.data!.token;
                  navigatAndRemove(context, LoginScreen.routName);
                });
                showToast(
                    text: '${state.RegisterModel.message}',
                    state: ToastState.SUCCESS);
              } else {
                showToast(
                    text: '${state.RegisterModel.message}',
                    state: ToastState.ERROR);
              }
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:  ListView(
                 physics: BouncingScrollPhysics(),
                  children: [
                    if(state is RegisterLodingStates)
                      LinearProgressIndicator(),
                    // Register text
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Register now to browse our hot offers',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultTextFile(
                            lable: 'Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            prefixIcon: Icons.perm_identity,
                            controller: nameController,
                            inputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFile(
                            lable: 'Phone number',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            prefixIcon: Icons.phone,
                            controller: phoneController,
                            inputType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFile(
                            lable: 'Email Address',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address';
                              }
                              return null;
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
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                            prefixIcon: Icons.lock_outline,
                            controller: passwordController,
                            inputType: TextInputType.visiblePassword,
                            suffixIcon: RegisterCubit.get(context).suffixIcon,
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffixOnPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: state is! RegisterLodingStates,
                      builder: (context) => defaultButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                            print(emailController.text + passwordController.text);
                          }
                        },
                        text: 'Register',
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 10,
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
