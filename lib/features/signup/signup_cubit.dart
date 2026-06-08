import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/signup/usecases/signup_create_user_usecase.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

enum SignupStatus {
  initial,
  loading,
  success,
  error,
}

class SignupState {
  //remove this usless thing
  const SignupState({
    this.username = '',
    this.status = SignupStatus.initial,
  });

  final String username;
  final SignupStatus status;

  SignupState copyWith({String? username, SignupStatus? status}) {
    return SignupState(
      username: username ?? this.username,
      status: status ?? this.status,
    );
  }
}

class SignupCubit extends Cubit<SignupState> {
  final AuthCreateUserUseCase authCreateUserUseCase;
  final AuthCubit authCubit;

  SignupCubit({required this.authCubit})
      : authCreateUserUseCase =
            AuthCreateUserUseCase(getIt<LocalStorageRepository>()),
        super(const SignupState());

  void updateUsername(String username) {
    //omg don't use that
    emit(state.copyWith(username: username));
  }

  Future<void> signup() async {
    if (state.username.isNullOrEmpty) {
      return;
    }

    emit(state.copyWith(status: SignupStatus.loading));
    try {
      final user = await authCreateUserUseCase.call(state.username);
      if (user) {
        authCubit.markSignedIn();
        emit(state.copyWith(status: SignupStatus.success));
      } else {
        emit(state.copyWith(status: SignupStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: SignupStatus.error));
    }
  }
}
