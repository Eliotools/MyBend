import 'package:mybend/core/constantes/local_storage_key.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class AuthCreateUserUseCase {
  final LocalStorageRepository _localStorageRepository;

  AuthCreateUserUseCase(this._localStorageRepository);

  Future<bool> call(String userName) async {
    if (userName.isNullOrEmpty) {
      throw Exception('User name is null or empty');
    }
    await _localStorageRepository.setValue(LocalStorageKey.userName, userName);
    return true;
  }
}
