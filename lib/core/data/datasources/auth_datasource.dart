import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const String apiUrl = 'https://api.meliot.tools/auth';

abstract class AuthDataSource {
  Future<String?> signIn(String username, String password);
  Future<String?> signUp(String username, String password);
}

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl();

  @override
  Future<String?> signIn(String username, String password) async {
    final response = await http.post(Uri.parse('$apiUrl/signin'), body: {
      'username': username,
      'password': password,
    });
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return body['token'];
  }

  @override
  Future<String?> signUp(String username, String password) async {
    final response = await http.post(Uri.parse('$apiUrl/signup'), body: {
      'username': username,
      'password': password,
    });
    if (response.statusCode == 409) {
      return await signIn(username, password);
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return body['token'];
  }
}
