import 'package:mybend/core/constantes/local_storage_key.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class AuthUserExiteUseCase {
  final LocalStorageRepository _localStorageRepository;

  AuthUserExiteUseCase(this._localStorageRepository);

  Future<bool> call() async {
    final userKey =
        await _localStorageRepository.getValue(LocalStorageKey.userName);
    return userKey.isNotNullOrEmpty;
  }
}
