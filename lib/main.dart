import 'package:flutter/widgets.dart';
import 'package:mybend/app.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/data/datasources/local_storage_datasource.dart';
import 'package:mybend/core/di/injections.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageDataSourceImpl.initialize();
  setupDependencyInjection();
  await getIt<AuthCubit>().checkAuthStatus();
  runApp(App());
}
