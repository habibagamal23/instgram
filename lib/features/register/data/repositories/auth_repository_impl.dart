import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../../core/firebase/firebase_storage.dart';
import '../models/UserModel.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _authService;
  final FirebaseStorageService _storageService;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._authService, this._storageService, this._firestore);

  @override
  Future<User?> signUp(String email, String password) async {
    try {
      return await _authService.signUpWithEmailAndPassword(email, password);
    } catch (e) {
      throw Exception("Sign Up Error: ${e.toString()}");
    }
  }

  @override
  Future<String?> uploadProfileImage(File imageFile, String uid) async {
    try {
      return await _storageService.uploadFile(
          file: imageFile, userId: uid, child: "profileImages");
    } catch (e) {
      throw Exception("Error uploadImage ${e.toString()}");
    }
  }

  @override
  Future<void> saveUserToFirestore(UserModel user) async {
    try {
      await _firestore
          .collection("users")
          .doc(user.uid)
          .set(user.toFirestore());
    } catch (e) {
      throw Exception("Error saving user to Firestore: ${e.toString()}");
    }
  }
}
