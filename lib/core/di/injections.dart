import 'package:get_it/get_it.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/data/datasources/local_storage_datasource.dart';
import 'package:mybend/features/babel/babel_cubit.dart';
import 'package:mybend/features/babel/usecases/get_babel_contents_usecase.dart';
import 'package:mybend/features/home/home_cubit.dart';
import 'package:mybend/features/signup/signup_cubit.dart';
import 'package:mybend/features/signup/usecases/signup_create_user_usecase.dart';
import 'package:mybend/core/auth/usecases/auth_user_exite_usecase.dart';
import 'package:mybend/core/auth/auth_cubit.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton<LocalStorageRepository>(LocalStorageRepositoryImpl(
      localStorageDataSource: LocalStorageDataSourceImpl()));
  getIt.registerSingleton<AuthUserExiteUseCase>(
      AuthUserExiteUseCase(getIt<LocalStorageRepository>()));
  getIt.registerSingleton<AuthCreateUserUseCase>(
      AuthCreateUserUseCase(getIt<LocalStorageRepository>()));
  getIt.registerSingleton<GetBabelContentsUseCase>(
      GetBabelContentsUseCase(getIt<LocalStorageRepository>()));
      getIt.registerLazySingleton(() => AuthCubit());
  getIt.registerLazySingleton(() => SignupCubit(authCubit: getIt<AuthCubit>()));
  getIt.registerLazySingleton(() => HomeCubit(authCubit: getIt<AuthCubit>()));
  getIt.registerLazySingleton(() => BabelCubit());
}
