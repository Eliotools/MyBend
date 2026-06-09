import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/auth/usecases/auth_user_exite_usecase.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/signup/usecases/signup_create_user_usecase.dart';
import 'package:mybend/src/shared/data_state.dart';

class AuthCubit extends Cubit<DataState> {
  final AuthUserExiteUseCase authUserExiteUseCase;
  final AuthCreateUserUseCase authCreateUserUseCase;
  AuthCubit()
      : authUserExiteUseCase =
            AuthUserExiteUseCase(getIt<LocalStorageRepository>()),
        authCreateUserUseCase =
            AuthCreateUserUseCase(getIt<LocalStorageRepository>()),
        super(const Initial());

  Future<void> checkAuthStatus() async {
    emit(const Loading());
    try {
      final bool isUserExiteUseCaseResult = await authUserExiteUseCase.call();
      if (isUserExiteUseCaseResult) {
        emit(const Loaded(true));
      } else {
        emit(const Loaded(false));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  void markSignedIn() => emit(const Loaded(true));

  void markSignUp() => emit(const Loaded(false));
}
