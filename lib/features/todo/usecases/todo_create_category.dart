import 'package:mybend/core/data/repositories/todo_repository.dart';
import 'package:mybend/features/todo/models/todo_category.dart';

class TodoCreateCategoryUseCase {
  TodoCreateCategoryUseCase(this._todoRepository);

  final TodoRepository _todoRepository;

  Future<TodoCategory> call(TodoCategory category) async =>
      _todoRepository.createCategory(category);
}
