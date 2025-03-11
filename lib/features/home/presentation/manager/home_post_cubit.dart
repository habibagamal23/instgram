import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../post/data/models/postmodel.dart';
import '../../../post/data/repositories/postrepo.dart';

part 'home_post_state.dart';

class HomePostCubit extends Cubit<HomePostState> {
  final PostRepositoryImplementation postRepository;

  HomePostCubit(this.postRepository) : super(HomePostInitial());

  void fetchHomePosts() {
    emit(HomePostLoading());
    postRepository.getAllHomePosts().listen(
          (posts) {
        emit(HomePostLoaded(posts));
      },
      onError: (error) {
        emit(HomePostError(error.toString()));
      },
    );
  }
}
