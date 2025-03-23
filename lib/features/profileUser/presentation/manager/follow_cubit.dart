import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../register/data/models/UserModel.dart';
import '../../data/repositories/repostiryprofile.dart';

part 'follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  ProfileRepository repo;
  FollowCubit(this.repo) : super(FollowInitial());


  followUsers(List<String> followUsersIds) async {
    emit(FollowLoading());
    try {
      final users = await repo.fetchFollowUsers(followUsersIds);
      emit(FollowLoaded(users));
    } catch (e) {
      emit(FollowError(e.toString()));
    }
  }

}
