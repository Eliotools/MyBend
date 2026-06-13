import 'package:mybend/core/data/repositories/todo_repository.dart';
import 'package:mybend/features/todo/models/todo_item.dart';

class TodoCreateUseCase {
  TodoCreateUseCase(this._todoRepository);

  final TodoRepository _todoRepository;

  Future<void> call(TodoItem todo) async => _todoRepository.createTodo(todo);
}
