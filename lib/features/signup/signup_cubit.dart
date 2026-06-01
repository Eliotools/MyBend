import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/signup/usecases/signup_create_user_usecase.dart';

enum BaseState {
  initial,
  loading,
  success,
  error,
}

class SignupCubit extends Cubit<BaseState> {
  final AuthCreateUserUseCase authCreateUserUseCase;

  SignupCubit()
      : authCreateUserUseCase =
            AuthCreateUserUseCase(getIt<LocalStorageRepository>()),
        super(BaseState.initial);

  Future<void> signup(String username) async {
    emit(BaseState.loading);
    try {
      final user = await authCreateUserUseCase.call(username);
      if (user) {
        emit(BaseState.success);
      } else {
        emit(BaseState.error);
      }
    } catch (e) {
      emit(BaseState.error);
    }
  }
}
