import 'package:mybend/core/data/repositories/auth_repository.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class AuthSignUpUseCase {
  final AuthRepository _authRepository;

  AuthSignUpUseCase(this._authRepository);

  Future<String?> call(String username, String password) async {
    if (username.isNullOrEmpty || password.isNullOrEmpty) {
      throw Exception('Username and password are required');
    }
    return await _authRepository.signUp(username, password);
  }
}
