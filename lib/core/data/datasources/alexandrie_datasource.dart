import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mybend/features/alexandrie/models/alexandrie_item.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_category.dart';
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/di/injections.dart';

const String alexApiUrl = 'https://api.meliot.tools/alexandrie';

abstract class AlexandrieDataSource {
  Future<List<AlexandrieItem>> getAlexItems();
  Future<AlexandrieItem> createAlexItem(AlexandrieItem item);
  Future<AlexandrieItem> updateAlexItem(AlexandrieItem item);
  Future<AlexandrieItem> setDueDate(AlexandrieItem item,
      {bool validated = false});
  Future<List<AlexandrieCategory>> getAlexCategories();
  Future<AlexandrieCategory> createAlexCategory(AlexandrieCategory category);
}

class AlexandrieDataSourceImpl implements AlexandrieDataSource {
  AlexandrieDataSourceImpl();

  Map<String, String> get _headers => {
        'Authorization': 'Bearer ${getIt<AuthCubit>().token}',
        'Content-Type': 'application/json',
      };

  @override
  Future<List<AlexandrieItem>> getAlexItems() async {
    final response =
        await http.get(Uri.parse('$alexApiUrl/'), headers: _headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get alex items: ${response.body}');
    }
    final body = jsonDecode(response.body) as List<dynamic>;
    return body.map((item) => AlexandrieItem.fromJson(item)).toList();
  }

  @override
  Future<AlexandrieItem> createAlexItem(AlexandrieItem item) async {
    final response = await http.post(
      Uri.parse('$alexApiUrl/'),
      headers: _headers,
      body: jsonEncode(item.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create alex item: ${response.body}');
    }
    return AlexandrieItem.fromJson(jsonDecode(response.body));
  }

  @override
  Future<AlexandrieItem> updateAlexItem(AlexandrieItem item) async {
    final response = await http.put(
      Uri.parse('$alexApiUrl/${item.id}'),
      headers: _headers,
      body: jsonEncode(item.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update alex item: ${response.body}');
    }
    return AlexandrieItem.fromJson(jsonDecode(response.body));
  }

  @override
  Future<AlexandrieItem> setDueDate(AlexandrieItem item,
      {bool validated = false}) async {
    final response = await http.put(
      Uri.parse('$alexApiUrl/${item.id}/due-date'),
      headers: _headers,
      body: jsonEncode({'validated': validated}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to set due date: ${response.body}');
    }
    return AlexandrieItem.fromJson(jsonDecode(response.body));
  }

  @override
  Future<List<AlexandrieCategory>> getAlexCategories() async {
    final response =
        await http.get(Uri.parse('$alexApiUrl/categories'), headers: _headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get alex categories: ${response.body}');
    }
    final body = jsonDecode(response.body) as List<dynamic>;
    return body
        .map((category) => AlexandrieCategory.fromJson(category))
        .toList();
  }

  @override
  Future<AlexandrieCategory> createAlexCategory(
      AlexandrieCategory category) async {
    final response = await http.post(
      Uri.parse('$alexApiUrl/categories'),
      headers: _headers,
      body: jsonEncode(category.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create alex category: ${response.body}');
    }
    return AlexandrieCategory.fromJson(jsonDecode(response.body));
  }
}
