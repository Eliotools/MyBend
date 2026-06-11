import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/constantes/local_storage_key.dart';

class AuthGetTokenUseCase {
  final LocalStorageRepository _localStorageRepository;

  AuthGetTokenUseCase(this._localStorageRepository);

  Future<String?> call() async =>
      await _localStorageRepository.getValue(LocalStorageKey.token);
}
