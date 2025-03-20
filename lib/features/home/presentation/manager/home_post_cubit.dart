import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../post/data/models/postmodel.dart';
import '../../../post/data/repositories/postrepo.dart';

part 'home_post_state.dart';

class HomePostCubit extends Cubit<HomePostState> {
  final PostRepositoryImplementation postRepository;

  HomePostCubit(this.postRepository) : super(HomePostInitial());

  StreamSubscription<List<PostModel>>? postSubscription;

  void fetchHomePosts() {
    emit(HomePostLoading());
    postSubscription=  postRepository.getAllHomePosts().listen(
          (posts) {
        emit(HomePostLoaded(posts));
      },
      onError: (error) {
        emit(HomePostError(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    postSubscription?.cancel();
    return super.close();
  }

}
