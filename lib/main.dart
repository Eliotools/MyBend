import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mybend/app.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/theme/theme_cubit.dart';
import 'package:mybend/core/data/datasources/local_storage_datasource.dart';
import 'package:mybend/core/di/injections.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await LocalStorageDataSourceImpl.initialize();
  setupDependencyInjection();
  await Future.wait([
    getIt<AuthCubit>().checkAuthStatus(),
    getIt<ThemeCubit>().load(),
  ]);
  runApp(App());
}
