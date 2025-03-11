import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../core/di/di.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../../core/firebase/firebase_storage.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit( ) : super(LoginInitial());
  final AuthRepositoryImpl authRepository= AuthRepositoryImpl( getIt<FirebaseAuthService>(),
      getIt<FirebaseStorageService>(),
      getIt<FirebaseFirestore>());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(email, password);
      if (user != null) {
        emit(AuthLoginSuccess(user)); // You can pass user data if needed
      } else {
        emit(AuthLoginFailure("Login failed"));
      }
    } catch (e) {
      emit(AuthLoginFailure(e.toString()));
    }
  }
}

