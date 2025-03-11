part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class AuthLoading extends LoginState {}

class AuthLoginSuccess extends LoginState {
  final User user;
  AuthLoginSuccess(this.user);
}

class AuthLoginFailure extends LoginState {
  final String errorMessage;
  AuthLoginFailure(this.errorMessage);
}