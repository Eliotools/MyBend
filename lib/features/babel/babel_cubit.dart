import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/babel/models/content.dart';
import 'package:mybend/features/babel/usecases/get_babel_contents_usecase.dart';

enum BabelStatus {
//check to make global status
  initial,
  loading,
  loaded,
  error,
}

class BabelState {
  //remove this usless thing
  const BabelState({
    this.status = BabelStatus.initial,
    this.selectedType = ContentType.movie,
    this.contents = const [],
  });

  final BabelStatus status;
  final ContentType selectedType;
  final List<Content> contents;

  List<Content> get filteredContents =>
      contents.where((content) => content.type == selectedType).toList();

  BabelState copyWith({
    BabelStatus? status,
    ContentType? selectedType,
    List<Content>? contents,
  }) {
    return BabelState(
      status: status ?? this.status,
      selectedType: selectedType ?? this.selectedType,
      contents: contents ?? this.contents,
    );
  }
}

class BabelCubit extends Cubit<BabelState> {
  BabelCubit()
      : _getBabelContentsUseCase = getIt<GetBabelContentsUseCase>(),
        super(const BabelState());

  final GetBabelContentsUseCase _getBabelContentsUseCase;

  Future<void> load() async {
    emit(state.copyWith(status: BabelStatus.loading));
    try {
      final contents = await _getBabelContentsUseCase.call();
      emit(state.copyWith(status: BabelStatus.loaded, contents: contents));
    } catch (e) {
      emit(state.copyWith(status: BabelStatus.error));
    }
  }

  void selectType(ContentType type) {
    emit(state.copyWith(selectedType: type));
  }
}
