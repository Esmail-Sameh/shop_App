import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/colors.dart';

void navigatAndRemove(BuildContext context, String routName) =>
    Navigator.pushReplacementNamed(context, routName);

void navigatTo(BuildContext context, String routName) =>
    Navigator.pushNamed(context, routName);

Widget defaultTextFile({
  required String lable,
  required IconData prefixIcon,
  required TextEditingController controller,
  required TextInputType inputType,
  GlobalKey<FormFieldState>? key,
  required String? Function(String?)? validator,
  Function()? onTap,
  Function(String)? onSubmitted,
  Function(String)? onChange,
  Function()? suffixOnPressed,
  bool isPassword = false,
  IconData? suffixIcon,
}) =>
    TextFormField(
      key: key,
      onTap: onTap ,
      onFieldSubmitted: onSubmitted ,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: lable,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixOnPressed,
        ),
      ),
      onChanged: onChange,
      controller: controller,
      keyboardType: inputType,
      validator: validator,
      obscureText: isPassword,
    );

Widget defaultButton({
  required void Function()? onPressed,
  required String text,
}) =>
    Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

Widget defaultTextButton(
        {required Function()? onPressed, required String text}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(text.toUpperCase()),
    );

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

//enum toast color
enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
