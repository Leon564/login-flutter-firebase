import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<User> signIn(String email, String password) async {
    final user = await _authRemoteDataSource.signIn(email, password);
    return User(
      id: user.id,
      username: user.username,
      email: user.email,
      password: '',
    );
  }

  @override
  Future<void> signOut() async {
    await _authRemoteDataSource.signOut();
  }

  @override
  Future<User> getUserData(String userId) async {
    final user = await _authRemoteDataSource.getUserData(userId);
    return User(
      id: user.id,
      username: user.username,
      email: user.email,
      password: '',
    );
  }

  @override
  Future<User> signUp(String name, String email, String password) async {
    final user = await _authRemoteDataSource.signUp(name, email, password);
    return User(
      id: user.id,
      username: user.username,
      email: user.email,
      password: '',
    );
  }
}
