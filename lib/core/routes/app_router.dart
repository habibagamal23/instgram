import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/register/presentation/pages/register_screen.dart';
import 'constants_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: ConstantsRoutes.registerScreen,
    routes: [
      GoRoute(
        path: ConstantsRoutes.registerScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
}
