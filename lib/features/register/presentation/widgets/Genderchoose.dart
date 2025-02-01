import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/register/register_cubit.dart';

class GenderDropdown extends StatelessWidget {
  const GenderDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: "Select Gender"),
          value: cubit.selectedGender,
          items: const [
            DropdownMenuItem(value: "Male", child: Text("Male")),
            DropdownMenuItem(value: "Female", child: Text("Female")),
            DropdownMenuItem(value: "Other", child: Text("Other")),
          ],
          onChanged: (value) {
            cubit.setGender(value);
          },
          validator: (value) =>
          value == null ? "Please select your gender" : null,
        );
      },
    );
  }
}
