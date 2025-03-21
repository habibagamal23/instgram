part of 'exploers_cubit.dart';

@immutable
sealed class ExploersState {}

final class ExploersInitial extends ExploersState {}

class ExploersLoading extends ExploersState {}

class ExploersLoaded extends ExploersState {
  final List<PostModel> posts;

  ExploersLoaded(this.posts);
}

class ExploersError extends ExploersState {
  final String error;

  ExploersError(this.error);
}