import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/auth/usecases/auth_user_exite_usecase.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/signup/usecases/signup_create_user_usecase.dart';

enum AuthState {
  initial,
  loading,
  signedIn,
  signUp,
}

class AuthCubit extends Cubit<AuthState> {
  final AuthUserExiteUseCase authUserExiteUseCase;
  final AuthCreateUserUseCase authCreateUserUseCase;
  AuthCubit()
      : authUserExiteUseCase =
            AuthUserExiteUseCase(getIt<LocalStorageRepository>()),
        authCreateUserUseCase =
            AuthCreateUserUseCase(getIt<LocalStorageRepository>()),
        super(AuthState.initial);

  /// Call on app start. Checks for user key in storage.
  Future<void> checkAuthStatus() async {
    emit(AuthState.loading);
    try {
      final bool isUserExiteUseCaseResult = await authUserExiteUseCase.call();
      if (isUserExiteUseCaseResult) {
        emit(AuthState.signedIn);
      } else {
        emit(AuthState.signUp);
      }
    } catch (e) {
      emit(AuthState.signUp);
    }
  }

  void markSignedIn() => emit(AuthState.signedIn);

  void markSignUp() => emit(AuthState.signUp);
}
