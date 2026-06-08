import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/constantes/local_storage_key.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required AuthCubit authCubit})
      : _localStorageRepository = getIt<LocalStorageRepository>(),
        _authCubit = authCubit,
        super(HomeState.initial);

  final LocalStorageRepository _localStorageRepository;
  final AuthCubit _authCubit;

  String? username;

  Future<void> load() async {
    emit(HomeState.loading);
    try {
      username =
          await _localStorageRepository.getValue(LocalStorageKey.userName);
      if (username.isNotNullOrEmpty) {
        emit(HomeState.loaded);
      } else {
        emit(HomeState.error);
      }
    } catch (e) {
      emit(HomeState.error);
    }
  }

  Future<void> clearStorage() async {
    await _localStorageRepository.clear();
    username = null;
    _authCubit.markSignUp();
    emit(HomeState.error);
  }
}
