import 'package:login_firebase/features/auth/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

class SignIn {
  final AuthRepository _authRepository;

  SignIn(this._authRepository);

  Future<User> call(String email, String password) async {
    return await _authRepository.signIn(email, password);
  }
}
