import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> signIn(String username, String password);
  Future<void> signOut();
  Future<User> getUserData(String userId);
  Future<User> signUp(String name, String email, String password);
}
