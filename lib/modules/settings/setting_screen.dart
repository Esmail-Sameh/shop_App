import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_status.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
       nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextFile(
                      lable: 'Name',
                      prefixIcon: Icons.person,
                      controller: nameController,
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Name';
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultTextFile(
                      lable: 'Email Address',
                      prefixIcon: Icons.email_outlined,
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email address';
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultTextFile(
                      lable: 'Phone',
                      prefixIcon: Icons.phone,
                      controller: phoneController,
                      inputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone';
                        }
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),
              defaultButton(
                  onPressed: () {signOut(context); cubit.currentIndex =0;},
                  text: 'Sign Out'),
              SizedBox(height: 10,),

              ConditionalBuilder(
                condition: state is! AppLodingUpdateUserDataState,
                builder: (context) => defaultButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.updateUserData(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                      );
                    }
                  },
                  text: 'Update',
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),

            ],
          ),
        );
      },
    );
  }
}
