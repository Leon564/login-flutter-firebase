import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:login_firebase/features/auth/domain/entities/user.dart';
import 'package:login_firebase/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/sign_in.dart';
import 'auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignIn signIn;
  final SignUp signUp;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthCubit(this.signIn, this.signUp) : super(AuthInitial()) {
    _loadUser(); // Cargar usuario al iniciar la app
  }
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await signIn(email, password);
      await _saveUser(user);
      debugPrint(user.email);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void logout() {
    _storage.delete(key: 'user');
    emit(AuthInitial());
  }

  Future<void> _saveUser(User user) async {
    await _storage.write(key: 'user', value: jsonEncode(user.toJson()));
  }

  Future<void> _loadUser() async {
    final userData = await _storage.read(key: 'user');
    if (userData != null) {
      final user = User.fromJson(jsonDecode(userData));
      debugPrint(user.toString());
      debugPrint(user.username);
      emit(AuthSuccess(user));
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await signUp(name, email, password);
      debugPrint(user.toString());
      debugPrint(user.username);
      await _saveUser(user);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
