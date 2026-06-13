import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/src/shared/data_state.dart';
import 'package:mybend/core/data/repositories/alexandrie_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_item.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_category.dart';
import 'package:mybend/shared/call_and_load.dart';

class AlexandrieLoadDto {
  AlexandrieLoadDto({required this.alexandries, required this.categories});
  final List<AlexandrieItem> alexandries;
  final List<AlexandrieCategory> categories;
}

class AlexandrieCubit extends Cubit<DataState> {
  AlexandrieCubit()
      : _alexandrieRepository = getIt<AlexandrieRepository>(),
        super(const Initial());

  final AlexandrieRepository _alexandrieRepository;

  Future<void> load() async => callAndLoad(
      () async => AlexandrieLoadDto(
            alexandries: await _alexandrieRepository.getAlexItems(),
            categories: await _alexandrieRepository.getAlexCategories(),
          ),
      emit);

  Future<void> createAlexandrie(AlexandrieItem alexandrie) async {
    await _alexandrieRepository.createAlexItem(alexandrie);
    load();
  }

  Future<void> updateAlexandrie(AlexandrieItem alexandrie) async {
    emit(const Loading());
    await _alexandrieRepository.updateAlexItem(alexandrie);
    load();
  }

  Future<void> createCategory(AlexandrieCategory category) async {
    await _alexandrieRepository.createAlexCategory(category);
    load();
  }

  Future<void> archiveAlexandrie(AlexandrieItem alexandrie) async {
    emit(const Loading());
    await _alexandrieRepository.setDueDate(alexandrie);
    load();
  }
}
