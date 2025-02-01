import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../../core/firebase/firebase_storage.dart';
import '../models/UserModel.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _authService;
  final FirebaseStorageService _storageService;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._authService , this._storageService , this._firestore);

  @override
  Future<User?> signUp(String email, String password) async {
    return await _authService.signUpWithEmailAndPassword(email, password);
  }

  @override
  Future<User?> signIn(String email, String password) async {
    return await _authService.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() async {
    await _authService.signOut();
  }

  @override
  Future<String?> uploadProfileImage(XFile imageFile) async {
    return await _storageService.uploadProfileImage(imageFile, _authService.currentUser!.uid, "profile_images");
  }

  @override
  Future<void> saveUserToFirestore(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.uid).set(user.toFirestore());
    } catch (e) {
      throw Exception("Error saving user to Firestore: $e");
    }
  }
}
