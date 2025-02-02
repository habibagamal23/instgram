
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/UserModel.dart';

abstract class AuthRepository {
  Future<User?> signUp(String email, String password);
  Future<String?> uploadProfileImage(File imageFile , String uid);
  Future<void> saveUserToFirestore(UserModel user);
}
