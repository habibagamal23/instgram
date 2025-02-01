import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../manager/register/register_cubit.dart';

class ChooseImageWidget extends StatelessWidget {
  const ChooseImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return GestureDetector(
      onTap: () => _showImageSourceDialog(context, cubit),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return CircleAvatar(
            radius: 50,
            backgroundImage: cubit.profileImage != null
                ? FileImage(cubit.profileImage!)
                : null,
            child: cubit.profileImage == null
                ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                : null,
          );
        },
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context, RegisterCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(context);
                  cubit.pickProfileImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  cubit.pickProfileImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
