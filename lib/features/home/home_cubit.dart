import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/src/shared/data_state.dart';

class HomeCubit extends Cubit<DataState> {
  HomeCubit()
      : _localStorageRepository = getIt<LocalStorageRepository>(),
        _authCubit = getIt<AuthCubit>(),
        super(const Initial());

  final LocalStorageRepository _localStorageRepository;
  final AuthCubit _authCubit;

  String? username;

  Future<void> clearStorage() async {
    await _localStorageRepository.clear();
    username = null;
    _authCubit.markSignUp();
    emit(const Error('Error clearing storage'));
  }
}
