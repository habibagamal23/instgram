import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/InstagramTextField.dart';
import '../manager/register/register_cubit.dart';
import 'Genderchoose.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return Column(
      children: [
        InstagramTextField(
          controller: cubit.usernameController,
          validator: (value) => value!.isEmpty ? "Username is required" : null,
          hintText: 'Username',
          isObscureText: false,
        ),
        InstagramTextField(
          controller: cubit.emailController,
          validator: (value) =>
          value!.isEmpty || !value.contains("@") ? "Enter a valid email" : null,
          hintText: 'Email',
          isObscureText: false,
        ),
        InstagramTextField(
          controller: cubit.passwordController,
          validator: (value) =>
          value!.length < 6 ? "Password must be at least 6 characters" : null,
          hintText: 'Password',
          isObscureText: true,
        ),
        InstagramTextField(
          controller: cubit.phoneController,
          validator: (value) =>
          value!.length < 10 ? "Enter a valid phone number" : null,
          hintText: 'Phone',
          isObscureText: false,
        ),
      ],
    );
  }
}
