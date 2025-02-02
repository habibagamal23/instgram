import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../features/register/data/repositories/auth_repository.dart';
import '../../features/register/data/repositories/auth_repository_impl.dart';
import '../../features/register/presentation/manager/register/register_cubit.dart';
import '../firebase/firebase_auth_service.dart';
import '../firebase/firebase_storage.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Register Firebase Instances
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Register Services
  getIt.registerLazySingleton<FirebaseAuthService>(
          () => FirebaseAuthService(getIt<FirebaseAuth>()));

  getIt.registerLazySingleton<FirebaseStorageService>(
          () => FirebaseStorageService(getIt<FirebaseStorage>()));

  // Register Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      getIt<FirebaseAuthService>(),
      getIt<FirebaseStorageService>(),
      getIt<FirebaseFirestore>()));

  // Register Cubits (Singleton to avoid multiple instances)
  getIt.registerLazySingleton<RegisterCubit>(
          () => RegisterCubit(authRepository: getIt<AuthRepository>()));
}
