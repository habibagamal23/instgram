part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user;
  final String profileImageUrl;
  RegisterSuccess(this.user, this.profileImageUrl);
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}

class ProfileImageSelected extends RegisterState {
  final File imageFile;
  ProfileImageSelected(this.imageFile);
}