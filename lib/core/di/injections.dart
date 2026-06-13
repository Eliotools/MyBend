import 'package:get_it/get_it.dart';
import 'package:mybend/core/data/repositories/local_storage_repository.dart';
import 'package:mybend/core/data/datasources/local_storage_datasource.dart';
import 'package:mybend/core/data/datasources/tmdb_datasource.dart';
import 'package:mybend/core/data/repositories/tmdb_repository.dart';
import 'package:mybend/features/babel/babel_cubit.dart';
import 'package:mybend/features/home/home_cubit.dart';
import 'package:mybend/features/signup/signup_cubit.dart';
import 'package:mybend/features/todo/todo_cubit.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/data/datasources/auth_datasource.dart';
import 'package:mybend/core/data/repositories/auth_repository.dart';
import 'package:mybend/core/data/datasources/babel_datasource.dart';
import 'package:mybend/core/data/datasources/todo_datasource.dart';
import 'package:mybend/core/data/repositories/babel_repository.dart';
import 'package:mybend/core/data/repositories/todo_repository.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton<LocalStorageRepository>(LocalStorageRepositoryImpl(
      localStorageDataSource: LocalStorageDataSourceImpl()));
  getIt.registerSingleton<BabelDataSource>(BabelDataSourceImpl());
  getIt.registerSingleton<BabelRepository>(
      BabelRepositoryImpl(getIt<BabelDataSource>()));
  getIt.registerSingleton<TodoDataSource>(TodoDataSourceImpl());
  getIt.registerSingleton<TodoRepository>(
      TodoRepositoryImpl(getIt<TodoDataSource>()));
  getIt.registerSingleton<AuthDataSource>(AuthDataSourceImpl());
  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(getIt<AuthDataSource>()));
  getIt.registerSingleton<TmdbDataSource>(TmdbDataSourceImpl());
  getIt.registerSingleton<TmdbRepository>(
      TmdbRepositoryImpl(tmdbDataSource: getIt<TmdbDataSource>()));
  getIt.registerLazySingleton(() => AuthCubit());
  //TODO(refactor cubit): move to factory
  getIt.registerLazySingleton(() => SignupCubit());
  getIt.registerLazySingleton(() => HomeCubit());
  getIt.registerLazySingleton(() => BabelCubit());
  getIt.registerLazySingleton(() => TodoCubit());
}
