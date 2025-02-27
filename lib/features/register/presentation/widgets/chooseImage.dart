import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../manager/register/register_cubit.dart';

class ChooseImageWidget extends StatelessWidget {
  const ChooseImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final ImagePicker picker = ImagePicker();

    return Center(
      child: GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Take a Photo
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Take a Photo"),
                    onTap: () async {
                      Navigator.pop(context);
                      try {
                        final pickedFile = await picker.pickImage(source: ImageSource.camera);
                        if (pickedFile != null) {
                          cubit.setImage(File(pickedFile.path));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error picking image: ${e.toString()}")),
                        );
                      }
                    },
                  ),
                  // Choose from Gallery
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Choose from Gallery"),
                    onTap: () async {
                      Navigator.pop(context);
                      try {
                        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          cubit.setImage(File(pickedFile.path));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error picking image: ${e.toString()}")),
                        );
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return CircleAvatar(
              radius: 50.r,
              backgroundImage: cubit.profileImage != null ? FileImage(cubit.profileImage!) : null,
              child: cubit.profileImage  == null
                  ? Icon(
                Icons.camera_alt,
                size: 40.sp,
                color: Colors.grey,
              )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
