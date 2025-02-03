import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:login_firebase/features/auth/presentation/cubit/auth_state.dart';
import 'package:login_firebase/routes.dart';

class MainLayout extends StatelessWidget {
  final Widget body; // Contenido dinámico de cada página

  const MainLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("login_firebase")),
      drawer: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        String userName = "Guest";
        String email = "Guest@email.com";

        if (state is AuthSuccess) {
          userName = state.user.username;
          email = state.user.email;
        }

        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(Icons.person, size: 40, color: Colors.blue),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userName,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      email,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Inicio"),
                onTap: () {
                  Navigator.pop(context); // Cierra el Drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Configuración"),
                onTap: () {
                  Navigator.pop(context);
                  //Navigator.pushNamed(context, AppRoutes.settings);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Cerrar sesión"),
                onTap: () {
                  Navigator.pop(context);
                  context.read<AuthCubit>().logout(); // Cerrar sesión
                  Navigator.pushNamed(
                      context, AppRoutes.signIn); // Redirigir al login
                },
              ),
            ],
          ),
        );
      }),
      body: body, // Contenido dinámico
    );
  }
}
