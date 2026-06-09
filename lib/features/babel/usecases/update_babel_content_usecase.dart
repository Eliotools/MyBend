import 'dart:convert';

import 'package:mybend/core/constantes/local_storage_key.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/features/babel/models/content.dart';

class UpdateBabelContentUseCase {
  UpdateBabelContentUseCase(this._localStorageRepository);

  final LocalStorageRepository _localStorageRepository;

  Future<void> call(List<Content> contents, Content content) async {
    final index = contents.indexWhere((c) => c.id == content.id);
    if (index == -1) return;

    contents[index] = content;

    await _localStorageRepository.setValue(
      LocalStorageKey.babel,
      jsonEncode(contents.map((c) => c.toJson()).toList()),
    );
  }
}
