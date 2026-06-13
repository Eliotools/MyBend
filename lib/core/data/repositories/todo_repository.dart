import 'package:mybend/core/data/datasources/todo_datasource.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/features/todo/models/todo_category.dart';

abstract class TodoRepository {
  Future<List<TodoItem>> getTodos();
  Future<List<TodoCategory>> getCategories();
  Future<void> createTodo(TodoItem todo);
  Future<void> updateTodo(TodoItem todo);
  Future<void> createCategory(TodoCategory category);
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._todoDataSource);

  final TodoDataSource _todoDataSource;

  @override
  Future<List<TodoItem>> getTodos() => _todoDataSource.getTodos();

  @override
  Future<void> createTodo(TodoItem todo) => _todoDataSource.createTodo(todo);

  @override
  Future<void> updateTodo(TodoItem todo) => _todoDataSource.updateTodo(todo);

  @override
  Future<void> createCategory(TodoCategory category) =>
      _todoDataSource.createCategory(category);

  @override
  Future<List<TodoCategory>> getCategories() => _todoDataSource.getCategories();
}
