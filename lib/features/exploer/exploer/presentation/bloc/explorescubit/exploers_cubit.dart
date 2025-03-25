import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/firebase/firebase_auth_service.dart';
import '../../../../../post/data/models/postmodel.dart';
import '../../../../../post/data/repositories/postrepo.dart';
part 'exploers_state.dart';

class ExploersCubit extends Cubit<ExploersState> {
  final PostRepositoryImplementation postRepository;

  ExploersCubit(this.postRepository) : super(ExploersInitial());


  StreamSubscription<List<PostModel>>? postSubscription;

  var currentUid = getIt<FirebaseAuthService>().currentUser!.uid;

  void fetchExploersPosts() {
    emit(ExploersLoading());
    postSubscription=  postRepository.getExploerPosts(currentUid).listen(
          (posts) {
        emit(ExploersLoaded(posts));
      },
      onError: (error) {
        emit(ExploersError(error.toString()));
      },
    );
  }
}
