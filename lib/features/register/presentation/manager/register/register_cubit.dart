import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../data/models/UserModel.dart';
import '../../../data/repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository authRepository;

  RegisterCubit({required this.authRepository}) : super(RegisterInitial());

  /// Text Controllers for Form Fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? selectedGender;
  File? profileImage;

  Future<void> pickProfileImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImageSelected(profileImage!));
    }
  }

  /// Signup Function
  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) {
      emit(RegisterError("Please fill all required fields correctly."));
      return;
    }

    emit(RegisterLoading());

    try {
      final user = await authRepository.signUp(
          emailController.text, passwordController.text);
      String? imageUrl;

      if (user != null) {
        if (profileImage != null) {
          imageUrl =
              await authRepository.uploadProfileImage(profileImage!, user.uid);
        }

        final newUser = UserModel(
          uid: user.uid,
          username: usernameController.text.trim(),
          email: emailController.text.trim(),
          profileUrl: imageUrl ?? "",
          bio:"",
          phone: phoneController.text.trim(),
          gender:  selectedGender??"Male",
          followers: [],
          following: [],
          totalFollowers: 0,
          totalFollowing: 0,
          totalPosts: 0,
          isOnline: true,
          token: "",
        );
        await authRepository.saveUserToFirestore(newUser);

        emit(RegisterSuccess(user, imageUrl ?? ""));
      } else {
        emit(RegisterError("Failed to register user"));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  void setGender(String? gender) {
    selectedGender = gender;
  }
}
