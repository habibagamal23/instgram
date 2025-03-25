import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/firebase/firebase_auth_service.dart';
import '../../../../../profileUser/data/repositories/repostiryprofile.dart';
import '../../../../../register/data/models/UserModel.dart';
import '../../../data/repository/searchrepo.dart';
import 'dart:async';

part 'ontherprofile_state.dart';

class OntherprofileCubit extends Cubit<OntherprofileState> {
  final SearchRepo repo;
  OntherprofileCubit(this.repo) : super(OntherprofileInitial());

  StreamSubscription<UserModel>? _subscription;

  void listenToUserProfile(String uid) {
    emit(OntherprofileLoading());
    _subscription?.cancel();
    _subscription = repo.getOntherUserProfileStream(uid).listen((user) {
      emit(OntherprofileLoaded(user));
    }, onError: (error) {
      emit(OntherprofileError("Error loading profile: $error"));
    });
  }

  var currentUid = getIt<FirebaseAuthService>().currentUser!.uid;
  Future<void> followAndUnfollowbystream(String targetUid) async {
    try {
      await repo.toggleFollow(currentUid, targetUid);
    } catch (e) {
      emit(OntherprofileError("Error toggling follow: $e"));
    }
  }

@override
  Future<void> close() {
    _subscription?.cancel();
    // TODO: implement close
    return super.close();
  }
}
