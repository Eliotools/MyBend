import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/signup/usecases/signup_create_user_usecase.dart';
import 'package:mybend/src/shared/data_state.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';


class SignupCubit extends Cubit<DataState> {
  final AuthCreateUserUseCase authCreateUserUseCase;
  final AuthCubit authCubit;

  SignupCubit()
      : authCreateUserUseCase =
            AuthCreateUserUseCase(getIt<LocalStorageRepository>()),
        authCubit = getIt<AuthCubit>(),
        super(const Initial());

  Future<void> signup(String username) async {
    if (username.isNullOrEmpty) {
      emit(const Error('Username is null or empty'));
      return;
    }

    emit(const Loading());
    try {
      final user = await authCreateUserUseCase.call(username);
      if (user) {
        authCubit.markSignedIn();
        emit(const Loaded(true));
      } else {
        emit(const Error('User not created'));
      }
    } catch (e) {
      emit( Error(e.toString()));
    }
  }
}
