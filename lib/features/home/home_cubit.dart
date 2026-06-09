import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/constantes/local_storage_key.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:mybend/src/shared/data_state.dart';

class HomeCubit extends Cubit<DataState> {
  HomeCubit({required AuthCubit authCubit})
      : _localStorageRepository = getIt<LocalStorageRepository>(),
        _authCubit = authCubit,
        super(const Initial());

  final LocalStorageRepository _localStorageRepository;
  final AuthCubit _authCubit;

  String? username;

  Future<void> load() async {
    emit(const Loading());
    try {
      username =
          await _localStorageRepository.getValue(LocalStorageKey.userName);
      if (username.isNotNullOrEmpty) {
        emit(Loaded(username));
      } else {
        emit(const Error('Username is null or empty'));
      }
    } catch (e) {
      emit( Error(e.toString()));
    }
  }

  Future<void> clearStorage() async {
    await _localStorageRepository.clear();
    username = null;
    _authCubit.markSignUp();
    emit(const Error('Error clearing storage'));
  }
}
