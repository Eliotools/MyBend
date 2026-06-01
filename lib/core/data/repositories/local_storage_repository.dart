import 'package:mybend/core/data/datasources/local_storage_datasource.dart';

abstract class LocalStorageRepository {
  Future<String?> getValue(String key);
  Future<void> setValue(String key, String value);
  Future<void> removeValue(String key);
  Future<void> clear();
}

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final LocalStorageDataSource localStorageDataSource;

  LocalStorageRepositoryImpl({required this.localStorageDataSource});

  @override
  Future<String?> getValue(String key) async =>
      localStorageDataSource.getValue(key);

  @override
  Future<void> setValue(String key, String value) async =>
      localStorageDataSource.setValue(key, value);

  @override
  Future<void> removeValue(String key) async =>
      localStorageDataSource.removeValue(key);

  @override
  Future<void> clear() async => localStorageDataSource.clear();
}
