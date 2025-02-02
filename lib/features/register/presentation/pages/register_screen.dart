import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/register/register_cubit.dart';
import '../widgets/Genderchoose.dart';
import '../widgets/chooseImage.dart';
import '../widgets/register_button.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: context.read<RegisterCubit>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: ChooseImageWidget()),
                 SizedBox(height: 20.h),
                const RegisterForm(),
                 SizedBox(height: 10.h),
                const GenderDropdown(),
                 SizedBox(height: 20.h),
                const RegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
