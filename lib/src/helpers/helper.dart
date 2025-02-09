import 'dart:convert';

import 'package:wyatt_type_utils/wyatt_type_utils.dart';

abstract final class Helper {
  static List<Object?> tryDecod(String? data) =>
      data.isNotNullOrEmpty ? jsonDecode(data!) as List<Object?> : [];

  static List<int> findAllIndexWhere(Object data, List<Object> list) {
    final List<int> result = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i] == data) {
        result.add(i);
      }
    }
    return result;
  }
}
