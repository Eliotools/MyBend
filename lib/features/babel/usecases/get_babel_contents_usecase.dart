import 'dart:convert';

import 'package:mybend/core/constantes/local_storage_key.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/features/babel/models/content.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class GetBabelContentsUseCase {
  GetBabelContentsUseCase(this._localStorageRepository);

  final LocalStorageRepository _localStorageRepository;

  Future<List<Content>> call() async {
    final raw = await _localStorageRepository.getValue(LocalStorageKey.babel);
    if (raw.isNullOrEmpty) {
      return [];
    }

    final list = jsonDecode(raw!) as List<dynamic>;
    return list
        .map((item) => Content.fromJson(Map<String, Object?>.from(item as Map)))
        .toList();
  }
}
