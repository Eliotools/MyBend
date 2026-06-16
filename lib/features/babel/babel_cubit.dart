import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/data/repositories/babel_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/babel/usecases/add_babel_content_usecase.dart';
import 'package:mybend/features/babel/usecases/get_babel_contents_usecase.dart';
import 'package:mybend/features/babel/usecases/update_babel_content_usecase.dart';
import 'package:mybend/features/babel/models/content.dart';
import 'package:mybend/shared/call_and_load.dart';
import 'package:mybend/src/shared/data_state.dart';

class BabelCubit extends Cubit<DataState> {
  BabelCubit()
      : _getBabelContentsUseCase =
            GetBabelContentsUseCase(getIt<BabelRepository>()),
        _addBabelContentUseCase =
            AddBabelContentUseCase(getIt<BabelRepository>()),
        _updateBabelContentUseCase =
            UpdateBabelContentUseCase(getIt<BabelRepository>()),
        super(const Initial());

  final GetBabelContentsUseCase _getBabelContentsUseCase;
  final AddBabelContentUseCase _addBabelContentUseCase;
  final UpdateBabelContentUseCase _updateBabelContentUseCase;

  Future<void> load() async => callAndLoad(() => _getBabelContentsUseCase.call(), emit);

  Future<void> addContent(Content content) async {
    await _addBabelContentUseCase.call(content);
    load();
  }

  Future<void> updateContent(Content content) async {
    await _updateBabelContentUseCase.call(content);
    load();
  }
}
