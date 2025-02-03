// lib/features/auth/domain/repositories/auth_repository.dart
import 'package:login_firebase/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> signIn(String email, String password);
  Future<void> signOut();
  Future<UserModel> getUserData(String userId);
  Future<UserModel> signUp(String name, String email, String password);
}
