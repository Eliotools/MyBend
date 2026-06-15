import 'package:flutter/material.dart';
import 'package:mybend/features/todo/models/todo_category.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/features/todo/todo_cubit.dart';
import 'package:mybend/features/todo/usecases/toto_load.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:mybend/features/todo/todo_card.dart';
import 'package:mybend/shared/ui/selector.dart';
import 'package:mybend/src/shared/data_state.dart';
import 'package:mybend/features/todo/todo_add_modal.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              builder: (context) =>
                  TodoAddModal(categories: state.data.categories),
            ).then((value) => value != null ? cubit.createTodo(value) : null),
            child: const Icon(Icons.add, color: Colors.white),
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
            todos: data.todos,
            categories: data.categories,
          ),
        _ => const SizedBox.shrink(),
      };
}

//TODO(refactor): move to separate file
class TodoContent extends StatefulWidget {
  const TodoContent({super.key, required this.todos, required this.categories});

  final List<TodoItem> todos;
  final List<TodoCategory> categories;

  @override
  State<TodoContent> createState() => _TodoContentState();
}

class _TodoContentState extends State<TodoContent> {
  String? selectedCategory;
  List<TodoItem> filteredTodos = [];

  @override
  void initState() {
    super.initState();
    filteredTodos = widget.todos;
  }

  @override
  Widget build(BuildContext context) =>
      ListView(scrollDirection: Axis.vertical, children: [
        widget.categories.isNotEmpty
            ? Selector(
                selectedItem: selectedCategory ?? '*',
                items:
                    widget.categories.map((category) => category.name).toList(),
                onSelected: (value) => setState(() {
                      selectedCategory = value;
                      if (value == '*') {
                        filteredTodos = widget.todos;
                      } else {
                        final valueId = widget.categories
                            .firstWhere((category) => category.name == value)
                            .id;
                        filteredTodos = widget.todos
                            .where((todo) => todo.categoryId == valueId)
                            .toList();
                      }
                    }),
                onAdd: (value) => context
                    .read<TodoCubit>()
                    .createCategory(TodoCategory(name: value)))
            : const Text('No categories'),
        const Gap(16),
        ...filteredTodos.map((todo) => TodoCard(
              todo: todo,
            ))
      ]);
}
