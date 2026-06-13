import 'package:mybend/core/data/repositories/todo_repository.dart';
import 'package:mybend/features/todo/models/todo_item.dart';

class TodoUpdateUseCase {
  TodoUpdateUseCase(this._todoRepository);

  final TodoRepository _todoRepository;

  Future<TodoItem> call(TodoItem todo) async => _todoRepository.updateTodo(todo);
}
