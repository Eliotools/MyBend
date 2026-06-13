import 'package:mybend/core/data/repositories/todo_repository.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/features/todo/models/todo_category.dart';

class TodoLoadDto {
  TodoLoadDto({required this.todos, required this.categories});

  final List<TodoItem> todos;
  final List<TodoCategory> categories;
}

class TodoLoadUseCase {
  TodoLoadUseCase(this._todoRepository);

  final TodoRepository _todoRepository;

  Future<TodoLoadDto> call() async {
    final todos = await _todoRepository.getTodos();
    final categories = await _todoRepository.getCategories();
    return TodoLoadDto(todos: todos, categories: categories);
  }
}
