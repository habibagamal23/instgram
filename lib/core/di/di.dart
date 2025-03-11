import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instaflutter/features/home/presentation/manager/home_post_cubit.dart';
import 'package:instaflutter/features/register/presentation/manager/login_cubit.dart';

import '../../features/post/data/repositories/postrepo.dart';
import '../../features/post/presentation/manager/post_cubit.dart';
import '../../features/profileUser/data/repositories/repostiryprofile.dart';
import '../../features/profileUser/presentation/manager/profile_cubit.dart';
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

  // Only register FirebaseStorageService once
  getIt.registerLazySingleton<FirebaseStorageService>(
          () => FirebaseStorageService(getIt<FirebaseStorage>()));

  // Register Repositories
  getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
      getIt<FirebaseAuthService>(),
      getIt<FirebaseStorageService>(),
      getIt<FirebaseFirestore>()));

  // Register Cubits (Singleton to avoid multiple instances)
  getIt.registerFactory<RegisterCubit>(
          () => RegisterCubit(authRepository: getIt<AuthRepository>()));

  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository(getIt<FirebaseFirestore>()));

  // Profile Cubit
  getIt.registerLazySingleton<ProfileCubit>(
          () => ProfileCubit(profileRepository: getIt<ProfileRepository>()));

  // Post Repository
  getIt.registerLazySingleton<PostRepositoryImplementation>(() =>
      PostRepositoryImplementation(
          getIt<FirebaseStorageService>(), getIt<FirebaseFirestore>()));

  // Post Cubit
  getIt.registerLazySingleton<PostCubit>(
          () => PostCubit(getIt<PostRepositoryImplementation>()));

//home cubit
  getIt.registerLazySingleton<HomePostCubit>(
          () => HomePostCubit(getIt<PostRepositoryImplementation>()));
}

