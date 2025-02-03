import 'package:login_firebase/features/auth/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

class SignUp {
  final AuthRepository _authRepository;

  SignUp(this._authRepository);

  Future<User> call(String name, String email, String password) async {
    return await _authRepository.signUp(name, email, password);
  }
}
