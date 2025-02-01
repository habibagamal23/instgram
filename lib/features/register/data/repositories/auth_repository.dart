
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../models/UserModel.dart';

abstract class AuthRepository {
  Future<User?> signUp(String email, String password);
  Future<User?> signIn(String email, String password);
  Future<String?> uploadProfileImage(XFile imageFile );
  Future<void> saveUserToFirestore(UserModel user);
  Future<void> signOut();
}
