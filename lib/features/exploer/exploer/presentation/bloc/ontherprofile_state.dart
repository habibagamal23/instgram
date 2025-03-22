part of 'ontherprofile_cubit.dart';

@immutable
sealed class OntherprofileState {}

final class OntherprofileInitial extends OntherprofileState {}
final class OntherprofileLoading extends OntherprofileState {}
final class OntherprofileLoaded extends OntherprofileState {
  final UserModel user;
  OntherprofileLoaded(this.user);
}
final class OntherprofileError extends OntherprofileState {
  final String message;
  OntherprofileError(this.message);
}