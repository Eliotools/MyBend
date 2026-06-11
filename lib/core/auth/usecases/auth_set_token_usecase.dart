import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/constantes/local_storage_key.dart';

class AuthSetTokenUseCase {
  final LocalStorageRepository _localStorageRepository;

  AuthSetTokenUseCase(this._localStorageRepository);

  Future<void> call(String token) async =>
      await _localStorageRepository.setValue(LocalStorageKey.token, token);
}
