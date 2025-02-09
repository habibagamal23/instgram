import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstagramTextField extends StatelessWidget{

  final String hintText;
  final TextEditingController? controller;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final InputDecoration? decoration;


  final String? Function(String?)? validator;

  const InstagramTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.isObscureText,
    this.suffixIcon,
    this.validator,
    this.decoration

  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 16.w,
          ),
          hintText: hintText,
          suffixIcon: suffixIcon,
      ),
      controller: controller,
      validator: validator,
      obscureText: isObscureText!,
    );
  }

}