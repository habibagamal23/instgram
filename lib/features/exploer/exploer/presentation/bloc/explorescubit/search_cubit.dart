import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../register/data/models/UserModel.dart';
import '../../../data/repository/searchrepo.dart';
import 'package:rxdart/rxdart.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  final _queryController = BehaviorSubject<String>();

  SearchCubit(this.searchRepo) : super(SearchInitial()) {
    // Listen to query stream with debounceTime
    _queryController.debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen(_handleSearchQuery);
  }

  void search(String query) {
    _queryController.add(query); // Add query to the stream
  }

  Future<void> _handleSearchQuery(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final users = await searchRepo.searchUsers(trimmedQuery);
      emit(SearchSuccess(users));
    } catch (e) {
      emit(SearchError('Error: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _queryController.close();
    return super.close();
  }

}
