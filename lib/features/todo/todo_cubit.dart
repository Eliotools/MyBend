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
import 'package:mybend/features/todo/usecases/todo_archive.dart';

class TodoCubit extends Cubit<DataState> {
  TodoCubit()
      : _todoLoadUseCase = TodoLoadUseCase(getIt<TodoRepository>()),
        _todoCreateUseCase = TodoCreateUseCase(getIt<TodoRepository>()),
        _todoUpdateUseCase = TodoUpdateUseCase(getIt<TodoRepository>()),
        _todoCreateCategoryUseCase =
            TodoCreateCategoryUseCase(getIt<TodoRepository>()),
        _todoArchiveUseCase = TodoArchiveUseCase(getIt<TodoRepository>()),
        super(const Initial());

  final TodoLoadUseCase _todoLoadUseCase;
  final TodoCreateUseCase _todoCreateUseCase;
  final TodoUpdateUseCase _todoUpdateUseCase;
  final TodoCreateCategoryUseCase _todoCreateCategoryUseCase;
  final TodoArchiveUseCase _todoArchiveUseCase;

  Future<void> load() async => callAndLoad(() => _todoLoadUseCase.call(), emit);

  Future<void> createTodo(TodoItem todo) async {
    await _todoCreateUseCase.call(todo);
    final data = await _todoLoadUseCase.call();
    emit(Loaded(data));
  }

  Future<void> updateTodo(TodoItem todo) async {
    await _todoUpdateUseCase.call(todo);
    //TODO(refactor): add a silent load method
    final data = await _todoLoadUseCase.call();
    emit(Loaded({data}));
  }

  Future<void> createCategory(TodoCategory category) async {
    await _todoCreateCategoryUseCase.call(category);
    load();
  }

  Future<void> archiveTodo(TodoItem todo) async {
    emit(const Loading());
    await _todoArchiveUseCase.call(todo);
    load();
  }
}
