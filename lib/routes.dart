import 'package:login_firebase/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:login_firebase/features/auth/presentation/cubit/auth_state.dart';
import 'package:login_firebase/features/auth/presentation/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/features/home/presentation/pages/home_page.dart';
import 'package:login_firebase/features/auth/presentation/pages/sign_in.dart';
import 'package:login_firebase/shared/pages/not_found_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static const String home = '/';
  static const String signIn = '/login';
  static const String signUp = '/signup';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      final authState = context.read<AuthCubit>().state;

      final bool isAuthenticated = authState is AuthSuccess;
      debugPrint(isAuthenticated.toString());
      switch (settings.name) {
        case home:
          return isAuthenticated ? const HomePage() : const SignInPage();
        //return MaterialPageRoute(builder: (_) => const SignInPage());
        case signIn:
          return const SignInPage();

        case signUp:
          return const SignUpPage();
        default:
          return NotFoundPage(routeName: settings.name);
        // return MaterialPageRoute(builder: (_) => const HomePage());
      }
    });
  }
}
