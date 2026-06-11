import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/src/shared/data_state.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:mybend/core/auth/usecases/auth_sign_up_usecase.dart';
import 'package:mybend/core/data/repositories/auth_repository.dart';

class SignupCubit extends Cubit<DataState> {
  final AuthSignUpUseCase authSignUpUseCase;
  final AuthCubit authCubit;

  SignupCubit()
      : authSignUpUseCase = AuthSignUpUseCase(getIt<AuthRepository>()),
        authCubit = getIt<AuthCubit>(),
        super(const Initial());

  Future<void> signup(String username, String password) async {
    if (username.isNullOrEmpty || password.isNullOrEmpty) {
      emit(const Error('Username is null or empty'));
      return;
    }

    emit(const Loading());
    try {
      final String? token = await authSignUpUseCase.call(username, password);
      if (token != null) {
        authCubit.setToken(token);
      } else {
        emit(const Error('User not created'));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
