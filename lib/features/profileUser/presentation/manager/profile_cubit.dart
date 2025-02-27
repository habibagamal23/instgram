import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../register/data/models/UserModel.dart';
import '../../data/repositories/repostiryprofile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit({required this.profileRepository}) : super(ProfileInitial());

  Future<void> fetchUserProfile() async {
    emit(ProfileLoading());
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final user = await profileRepository.getUserProfile(uid);
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError("User is not logged in"));
      }
    } catch (e) {
      emit(ProfileError("Error loading profile: $e"));
    }
  }
}