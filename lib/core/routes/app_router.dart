import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/mainScreen.dart';
import '../../features/register/presentation/pages/loginscreen.dart';
import '../../features/register/presentation/pages/register_screen.dart';
import 'constants_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: ConstantsRoutes.registerScreen,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: ConstantsRoutes.registerScreen,
        builder: (context, state) =>  RegisterScreen(),
      ),
      GoRoute(
        path: ConstantsRoutes.homeScreen,
        builder: (context, state) => const MainScreen(),
      ),
    ],

    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        appBar: AppBar(title: const Text("Page Not Found")),
        body: const Center(child: Text("404 - Page Not Found")),
      ),
    ),
  );
}
