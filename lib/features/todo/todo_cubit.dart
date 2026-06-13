import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/src/shared/data_state.dart';
import 'package:mybend/core/data/repositories/todo_repository.dart';
import 'package:mybend/features/todo/usecases/todo_create.dart';
import 'package:mybend/features/todo/usecases/todo_update.dart';
import 'package:mybend/features/todo/usecases/todo_create_category.dart';
import 'package:mybend/features/todo/usecases/toto_load.dart';
import 'package:mybend/core/di/injections.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/features/todo/models/todo_category.dart';
import 'package:mybend/shared/call_and_load.dart';

class TodoCubit extends Cubit<DataState> {
  TodoCubit()
      : _todoLoadUseCase = TodoLoadUseCase(getIt<TodoRepository>()),
        _todoCreateUseCase = TodoCreateUseCase(getIt<TodoRepository>()),
        _todoUpdateUseCase = TodoUpdateUseCase(getIt<TodoRepository>()),
        _todoCreateCategoryUseCase =
            TodoCreateCategoryUseCase(getIt<TodoRepository>()),
        super(const Initial());

  final TodoLoadUseCase _todoLoadUseCase;
  final TodoCreateUseCase _todoCreateUseCase;
  final TodoUpdateUseCase _todoUpdateUseCase;
  final TodoCreateCategoryUseCase _todoCreateCategoryUseCase;

  Future<void> load() async => callAndLoad(() => _todoLoadUseCase.call(), emit);

  Future<void> createTodo(TodoItem todo) async =>
      callAndLoad(() => _todoCreateUseCase.call(todo), emit);

  Future<void> updateTodo(TodoItem todo) async =>
      callAndLoad(() => _todoUpdateUseCase.call(todo), emit);

  Future<void> createCategory(TodoCategory category) async =>
      callAndLoad(() => _todoCreateCategoryUseCase.call(category), emit);
}
