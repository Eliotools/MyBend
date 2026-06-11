import 'package:mybend/core/data/datasources/auth_datasource.dart';

abstract class AuthRepository {
  Future<String?> signIn(String username, String password);
  Future<String?> signUp(String username, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<String?> signIn(String username, String password) async {
    return await authDataSource.signIn(username, password);
  }

  @override
  Future<String?> signUp(String username, String password) async {
    return await authDataSource.signUp(username, password);
  }
}
