import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:login_firebase/features/auth/presentation/cubit/auth_state.dart';
import 'package:login_firebase/shared/layouts/main_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        builder: (context, state) {
          if (state is AuthInitial) {
            return const Center(child: Text('Por favor, inicie sesión'));
          } else if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            return const Center(
              child: Text('Your app content goes here 🌿👀🌿'),
            );
          } else if (state is AuthFailure) {
            return Center(child: Text(state.message));
          }
          return const SizedBox(); // Vacío en caso de otro estado no manejado
        },
      ),
    );
  }
}
