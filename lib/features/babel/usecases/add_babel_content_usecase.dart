import 'dart:convert';

import 'package:mybend/core/constantes/local_storage_key.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/features/babel/models/content.dart';

class AddBabelContentUseCase {
  AddBabelContentUseCase(this._localStorageRepository);

  final LocalStorageRepository _localStorageRepository;

  Future<void> call(List<Content> contents, Content content) async {
    final id = contents.isEmpty
        ? 0
        : contents.map((c) => c.id).reduce((a, b) => a > b ? a : b) + 1;

    contents.add(
      Content(
        id: id,
        name: content.name,
        type: content.type,
        time: content.time,
        rating: content.rating,
        status: content.status,
        comments: content.comments,
        imageUrl: content.imageUrl,
      ),
    );

    await _localStorageRepository.setValue(
      LocalStorageKey.babel,
      jsonEncode(contents.map((c) => c.toJson()).toList()),
    );
  }
}
