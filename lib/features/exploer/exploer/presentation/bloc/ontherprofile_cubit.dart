import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../profileUser/data/repositories/repostiryprofile.dart';
import '../../../../register/data/models/UserModel.dart';
import '../../data/repository/searchrepo.dart';

part 'ontherprofile_state.dart';

class OntherprofileCubit extends Cubit<OntherprofileState> {
  final SearchRepo repo;
  OntherprofileCubit(this.repo) : super(OntherprofileInitial());

  Future<void> fetchUserProfile(String userid) async {
    emit(OntherprofileLoading());
    try {
        final user = await repo.getOntheruserProfile(userid);
          emit(OntherprofileLoaded(user));
          debugPrint("user ${user!.email}");

    } catch (e) {
      emit(OntherprofileError("Error loading profile: $e"));
    }
  }
}
