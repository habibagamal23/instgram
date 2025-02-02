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

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? selectedGender;
  File? profileImage;

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) {
      emit(RegisterError("Please fill all required fields correctly."));
      return;
    }

    emit(RegisterLoading());

    try {
      final user = await authRepository.signUp(
          emailController.text, passwordController.text);

      if (user == null) {
        emit(RegisterError("Failed to register user."));
        return;
      }

      String? imageUrl;

      if (profileImage != null) {
        imageUrl = await authRepository.uploadProfileImage(profileImage!, user.uid);
      }

      final newUser = UserModel(
        uid: user.uid,
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        profileUrl: imageUrl ?? "",
        bio: "",
        phone: phoneController.text.trim(),
        gender: selectedGender,
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
    } catch (e) {
      emit(RegisterError("An error occurred: ${e.toString()}"));
    }
  }

  void setGender(String? gender) {
    selectedGender = gender ?? "Male";
    emit(GenderSelected(selectedGender!));
  }

  void setImage(File image) {
    profileImage = image;
    emit(ProfileImageSelected(image));
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}