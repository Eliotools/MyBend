import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/auth/usecases/auth_sign_in_usecase.dart';
import 'package:mybend/core/auth/usecases/auth_sign_up_usecase.dart';
import 'package:mybend/core/auth/usecases/auth_get_token_usecase.dart';
import 'package:mybend/core/auth/usecases/auth_set_token_usecase.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/src/shared/data_state.dart';
import 'package:mybend/core/data/repositories/auth_repository.dart';

class AuthCubit extends Cubit<DataState> {
  final AuthSignUpUseCase authSignUpUseCase;
  final AuthSignInUseCase authSignInUseCase;
  final AuthGetTokenUseCase authGetTokenUseCase;
  final AuthSetTokenUseCase authSetTokenUseCase;
  AuthCubit()
      : authSignUpUseCase = AuthSignUpUseCase(getIt<AuthRepository>()),
        authSignInUseCase = AuthSignInUseCase(getIt<AuthRepository>()),
        authGetTokenUseCase =
            AuthGetTokenUseCase(getIt<LocalStorageRepository>()),
        authSetTokenUseCase =
            AuthSetTokenUseCase(getIt<LocalStorageRepository>()),
        super(const Initial());


      

  String? _token;
  //username not used
  String? _username;

  String? get token => _token;
  String? get username => _username;

  Future<void> checkAuthStatus() async {
    emit(const Loading());
    try {
      final String? token = await authGetTokenUseCase.call();
      if (token != null) {
        _token = token;
        emit(const Loaded(true));
      } else {
        emit(const Loaded(false));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> signIn(String username, String password) async {
    emit(const Loading());
    try {
      final String? token = await authSignInUseCase.call(username, password);
      if (token != null) {
        await setToken(token);
      } else {
        emit(const Error('Invalid username or password'));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> setToken(String token) async {
    _token = token;
    await authSetTokenUseCase.call(token);
    emit(const Loaded(true));
  }

  void markSignUp() => emit(const Loaded(false));
  //add a logout method
}
