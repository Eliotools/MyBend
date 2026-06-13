import 'package:mybend/core/data/datasources/todo_datasource.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/features/todo/models/todo_category.dart';

abstract class TodoRepository {
  Future<List<TodoItem>> getTodos();
  Future<List<TodoCategory>> getCategories();
  Future<TodoItem> createTodo(TodoItem todo);
  Future<TodoItem> updateTodo(TodoItem todo);
  Future<TodoCategory> createCategory(TodoCategory category);
  Future<bool> archiveTodo(TodoItem todo);
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._todoDataSource);

  final TodoDataSource _todoDataSource;

  @override
  Future<List<TodoItem>> getTodos() => _todoDataSource.getTodos();

  @override
  Future<TodoItem> createTodo(TodoItem todo) =>
      _todoDataSource.createTodo(todo);

  @override
  Future<TodoItem> updateTodo(TodoItem todo) =>
      _todoDataSource.updateTodo(todo);

  @override
  Future<TodoCategory> createCategory(TodoCategory category) =>
      _todoDataSource.createCategory(category);

  @override
  Future<List<TodoCategory>> getCategories() => _todoDataSource.getCategories();

  @override
  Future<bool> archiveTodo(TodoItem todo) => _todoDataSource.archiveTodo(todo);
}
