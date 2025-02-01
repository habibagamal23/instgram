import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/InstagramButton.dart';
import '../manager/register/register_cubit.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration Successful! Welcome ${state.user.email}")),
          );
          // Navigate to home screen
        } else if (state is RegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<RegisterCubit>();

        if( state is RegisterLoading){
         Center(child: const CircularProgressIndicator());
        }

        return InstagramButton(
          onPressed: cubit.signUp,
          text: 'Register',
        );
      },
    );
  }
}
