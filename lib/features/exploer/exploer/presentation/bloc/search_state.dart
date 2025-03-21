part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<UserModel> users;

  SearchSuccess(this.users);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}