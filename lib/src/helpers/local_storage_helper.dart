import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class LocalStorageHelper {
  LocalStorageHelper();

  static void init() async => initLocalStorage();

  static Object? getItemOrNull(LocalStorageKeyEnum key, {bool parse = false}) {
    final result = localStorage.getItem(key.name);
    if (result.isNotNull && parse) {
      return jsonDecode(result!);
    }
    return result;
  }

  static void setItem(LocalStorageKeyEnum key, Object item) =>
      localStorage.setItem(key.name, jsonEncode(item));

  static void addItem(LocalStorageKeyEnum key, Object? item) {
    final list = getItemOrNull(key, parse: true) as List? ?? [];
    list.add(item);
    setItem(key, list);
  }

  static void clearItem(LocalStorageKeyEnum key) =>
      localStorage.removeItem(key.name);

  static void addIntItem(LocalStorageKeyEnum key, int value) {
    final data = (int.tryParse(getItemOrNull(key).toString()) ?? 0);
    setItem(key, data + value);
  }

  static void calcXP() {
    final history =
        getItemOrNull(LocalStorageKeyEnum.history, parse: true) as List? ?? [];
    final xp = history.map((e) => e['time']).reduce((a, b) {
      if (b is String) {
        return a + int.parse(b);
      }
      if (a is int && b is int) {
        return a + b;
      }

      return a;
    });
    setItem(LocalStorageKeyEnum.xp, xp ~/ 6);
  }

  static void removeIndex(LocalStorageKeyEnum key, int index) {
    final list = getItemOrNull(key, parse: true) as List? ?? [];
    list.removeAt(index);
    setItem(key, list);
  }

  static void clear() => localStorage.clear();
}
