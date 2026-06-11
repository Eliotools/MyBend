import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/babel/models/content.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiUrl = 'https://api.meliot.tools/babel';

abstract class BabelDataSource {
  Future<List<Content>> getBabelContents();
  Future<void> addBabelContent(Content content);
  Future<void> updateBabelContent(Content content);
  Future<void> deleteBabelContent(Content content);
}

class BabelDataSourceImpl implements BabelDataSource {
  BabelDataSourceImpl();

  Map<String, String> get _headers => {
        'Authorization': 'Bearer ${getIt<AuthCubit>().token}',
        'Content-Type': 'application/json',
      };

  @override
  Future<List<Content>> getBabelContents() async {
    final response = await http.get(Uri.parse('$apiUrl/'), headers: {
      'Authorization': 'Bearer ${getIt<AuthCubit>().token}',
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to get babel contents: ${response.body}');
    }
    final body = jsonDecode(response.body) as List<dynamic>;
    return body.map((content) => Content.fromJson(content)).toList();
  }

  @override
  Future<void> addBabelContent(Content content) async {
    final response = await http.post(
      Uri.parse('$apiUrl/'),
      body: jsonEncode(content.toJson()),
      headers: _headers,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add babel content: ${response.body}');
    }
  }

  @override
  Future<void> updateBabelContent(Content content) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${content.id}'),
      headers: _headers,
      body: jsonEncode(content.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update babel content: ${response.body}');
    }
  }

  @override
  Future<void> deleteBabelContent(Content content) async =>
      await http.delete(Uri.parse('$apiUrl/${content.id}'), headers: {
        'Authorization': 'Bearer ${getIt<AuthCubit>().token}',
      });
}
