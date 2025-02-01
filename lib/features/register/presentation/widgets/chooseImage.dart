import 'dart:io';
import 'package:flutter/foundation.dart'; // Required for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../manager/register/register_cubit.dart';

class ChooseImageWidget extends StatelessWidget {
  const ChooseImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showImageSourceDialog(context),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          final cubit = context.watch<RegisterCubit>();

          return CircleAvatar(
            radius: 50,
            backgroundImage: _getImageProvider(cubit),
            child: cubit.profileImage == null && cubit.profileImageUrl == null
                ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                : null,
          );
        },
      ),
    );
  }

  /// **Fix: Handle Web & Mobile Image Loading Correctly**
  ImageProvider<Object>? _getImageProvider(RegisterCubit cubit) {
    if (cubit.profileImageUrl != null && cubit.profileImageUrl!.isNotEmpty) {
      return NetworkImage(cubit.profileImageUrl!); // ✅ Use Firebase URL
    }
    if (!kIsWeb && cubit.profileImage != null) {
      return FileImage(File(cubit.profileImage!.path)); // ✅ Mobile File Image
    }
    return null; // No image selected
  }


  void _showImageSourceDialog(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

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
                  cubit.pickAndUploadProfileImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  cubit.pickAndUploadProfileImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
