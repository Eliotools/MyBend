import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mybend/core/auth/auth_cubit.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/features/todo/models/todo_category.dart';

const String todoApiUrl = 'https://api.meliot.tools/todo';

abstract class TodoDataSource {
  Future<List<TodoItem>> getTodos();
  Future<List<TodoCategory>> getCategories();
  Future<void> createTodo(TodoItem todo);
  Future<void> updateTodo(TodoItem todo);
  Future<void> createCategory(TodoCategory category);
}

class TodoDataSourceImpl implements TodoDataSource {
  TodoDataSourceImpl();

  Map<String, String> get _headers => {
        'Authorization': 'Bearer ${getIt<AuthCubit>().token}',
        'Content-Type': 'application/json',
      };

  @override
  Future<List<TodoItem>> getTodos() async {
    final response =
        await http.get(Uri.parse('$todoApiUrl/'), headers: _headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get todos: ${response.body}');
    }
    print(response.body);
    print(response.statusCode);
    final body = jsonDecode(response.body) as List<dynamic>;
    return body
        .map(
          (todo) => TodoItem.fromJson(Map<String, Object?>.from(todo as Map)),
        )
        .toList();
  }

  @override
  Future<List<TodoCategory>> getCategories() async {
    final response =
        await http.get(Uri.parse('$todoApiUrl/categories'), headers: _headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to get categories: ${response.body}');
    }
    print(response.body);
    print(response.statusCode);
    final body = jsonDecode(response.body) as List<dynamic>;
    return body
        .map(
          (category) =>
              TodoCategory.fromJson(Map<String, Object?>.from(category as Map)),
        )
        .toList();
  }

  @override
  Future<void> createTodo(TodoItem todo) async {
    final response = await http.post(
      Uri.parse('$todoApiUrl/'),
      headers: _headers,
      body: jsonEncode(todo.toJson()),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add todo: ${response.body}');
    }
  }

  @override
  Future<void> updateTodo(TodoItem todo) async {
    final response = await http.put(
      Uri.parse('$todoApiUrl/${todo.id}'),
      headers: _headers,
      body: jsonEncode(todo.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update todo: ${response.body}');
    }
  }

  @override
  Future<void> createCategory(TodoCategory category) async {
    final response = await http.delete(
      Uri.parse('$todoApiUrl/category'),
      headers: _headers,
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete todo: ${response.body}');
    }
  }
}
