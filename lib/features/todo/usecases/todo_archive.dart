import 'package:mybend/core/data/repositories/todo_repository.dart';
import 'package:mybend/features/todo/models/todo_item.dart';

class TodoArchiveUseCase {
  TodoArchiveUseCase(this._todoRepository);

  final TodoRepository _todoRepository;

  Future<bool> call(TodoItem todo) async => _todoRepository.archiveTodo(todo);
}