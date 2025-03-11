import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../register/data/models/UserModel.dart';
import '../../data/repositories/repostiryprofile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit({required this.profileRepository}) : super(ProfileInitial());

  final TextEditingController bioController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  UserModel? currentUser;



  Future<void> fetchUserProfile() async {
    // Check if user is already loaded in memory
    // if (currentUser != null) {
    //   emit(ProfileLoaded(currentUser!));
    //   return; // Return early if user is already cached in memory
    // }

    emit(ProfileLoading());
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final user = await profileRepository.getUserProfile(uid);
        if (user != null) {
          currentUser = user;
          debugPrint("user ${currentUser!.email!}");
          websiteController.text = user.website ?? "";
          bioController.text = user.bio ?? "";
          emit(ProfileLoaded(user));
          debugPrint("user ${currentUser!.email}");
        }  else {
          emit(ProfileError("User is  get data error"));
        }

      } else {
        emit(ProfileError("User is not logged in"));
      }
    } catch (e) {
      emit(ProfileError("Error loading profile: $e"));
    }
  }

  // Update user profile in Firestore
  Future<void> updateUserProfile() async {
    if (currentUser == null) return;

    emit(ProfileLoading());
    try {
      UserModel updatedUser = UserModel(
        uid: currentUser!.uid,
        username: currentUser!.username,
        bio: bioController.text,
        phone: currentUser!.phone,
        website: websiteController.text.trim(),
        email: currentUser!.email,
        profileUrl: currentUser!.profileUrl,
        followers: currentUser!.followers,
        following: currentUser!.following,
        totalFollowers: currentUser!.totalFollowers,
        totalFollowing: currentUser!.totalFollowing,
        totalPosts: currentUser!.totalPosts,
        isOnline: currentUser!.isOnline,
        token: currentUser!.token,
      );

      await profileRepository.updateUserProfile(updatedUser);
      debugPrint("user $currentUser");
      currentUser = updatedUser;
      debugPrint("user updated ${updatedUser.email}");
      emit(ProfileLoaded(updatedUser));
      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileError("Error updating profile: $e"));
    }
  }
}