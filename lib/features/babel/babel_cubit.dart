import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/babel/usecases/get_babel_contents_usecase.dart';
import 'package:mybend/src/shared/data_state.dart';




class BabelCubit extends Cubit<DataState> {
  BabelCubit()
      : _getBabelContentsUseCase = getIt<GetBabelContentsUseCase>(),
        super(const Initial());

  final GetBabelContentsUseCase _getBabelContentsUseCase;

  Future<void> load() async {
    print('==========================call=========================');
    emit(const Loading());
    try {
      final contents = await _getBabelContentsUseCase.call();
      emit(Loaded(contents));
    } catch (e) {
      emit( Error(e.toString()));
    }
  }
}
