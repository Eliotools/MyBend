import 'dart:async';
import 'package:localstorage/localstorage.dart';

abstract class LocalStorageDataSource {
  Future<String?> getValue(String key);
  Future<void> setValue(String key, String value);
  Future<void> removeValue(String key);
  Future<void> clear();
}

class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  LocalStorageDataSourceImpl();

  static Future<void> initialize() => initLocalStorage();

  @override
  Future<String?> getValue(String key) async {
    try {
      final value = localStorage.getItem(key);
      return value;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setValue(String key, String value) async =>
      localStorage.setItem(key, value);

  @override
  Future<void> removeValue(String key) async => localStorage.removeItem(key);

  @override
  Future<void> clear() async => localStorage.clear();
}
