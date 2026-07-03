import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/features/todo/todo_cubit.dart';
import 'package:mybend/features/todo/usecases/toto_load.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:mybend/features/todo/todo_card.dart';
import 'package:mybend/shared/ui/custom_container.dart';
import 'package:mybend/src/shared/data_state.dart';
import 'package:mybend/features/todo/todo_add_modal.dart';
import 'package:gap/gap.dart';

class TodoScreen extends CubitScreen<TodoCubit, DataState> {
  const TodoScreen({super.key});

  @override
  String get name => 'Todo';

  @override
  void Function(TodoCubit cubit)? get onInit => (cubit) => cubit.load();

  @override
  Widget Function(BuildContext context,
      DataState state)? get floatingActionButton => (context, state) => state
          is Loaded<TodoLoadDto>
      ? Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => showModalBottomSheet<TodoItem?>(
              isScrollControlled: true,
              context: context,
              builder: (context) => const TodoAddModal(),
            ).then((value) => value != null ? cubit.createTodo(value) : null),
            child: const Icon(Icons.add),
          ),
        )
      : const SizedBox.shrink();

  @override
  Widget buildPage(BuildContext context, DataState state) => switch (state) {
        Initial() || Loading() => const Center(
            child: CircularProgressIndicator(),
          ),
        Error(message: final message) => Center(
            child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
          ),
        Loaded<TodoLoadDto>(data: final data) => TodoContent(
            state: data,
          ),
        _ => const SizedBox.shrink(),
      };
}

//TODO(refactor): move to separate file
class TodoContent extends StatefulWidget {
  const TodoContent({super.key, required this.state});

  final TodoLoadDto state;

  @override
  State<TodoContent> createState() => _TodoContentState();
}

class _TodoContentState extends State<TodoContent> {
  List<TodoItem> filteredTodos = [];

  @override
  void initState() {
    super.initState();
    filteredTodos = filterTodos(widget.state);
  }

  @override
  Widget build(BuildContext context) =>
      ListView(scrollDirection: Axis.vertical, children: [
        widget.state.categories.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.state.categories
                      .map((category) => CustomContainer(
                            selected: widget.state.selectedCategories
                                .contains(category),
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<TodoCubit>()
                                    .selectCategory(category);
                                setState(() =>
                                    filteredTodos = filterTodos(widget.state));
                              },
                              child: SizedBox(
                                  width: 80,
                                  child: Center(child: Text(category.name))),
                            ),
                          ))
                      .toList(),
                ),
              )
            : const Text('No categories'),
        const Gap(16),
        ...filteredTodos.map((todo) => TodoCard(todo: todo)),
      ]);
}

List<TodoItem> filterTodos(TodoLoadDto state) {
  if (state.selectedCategories.isEmpty) {
    return state.todos;
  }
  List<int> categoryIds =
      state.selectedCategories.map((category) => category.id).toList();

  return state.todos
      .where((todo) => categoryIds.contains(todo.categoryId))
      .toList();
}
