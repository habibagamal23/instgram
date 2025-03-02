import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/di.dart';
import 'core/routes/app_router.dart';
import 'features/profileUser/data/repositories/repostiryprofile.dart';
import 'features/profileUser/presentation/manager/profile_cubit.dart';
import 'features/register/presentation/manager/register/register_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupGetIt();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => getIt<RegisterCubit>()),
  BlocProvider(
  create: (context) => ProfileCubit(
  profileRepository: ProfileRepository(FirebaseFirestore.instance),
  )..fetchUserProfile()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 944),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
