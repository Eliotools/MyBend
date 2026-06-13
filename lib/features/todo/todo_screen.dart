import 'package:flutter/material.dart';
import 'package:mybend/core/themes/app_theme.dart';
import 'package:mybend/features/todo/models/todo_category.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/features/todo/todo_cubit.dart';
import 'package:mybend/features/todo/usecases/toto_load.dart';
import 'package:mybend/shared/cubit_screen.dart';
import 'package:mybend/shared/custom_container.dart';
import 'package:mybend/src/shared/data_state.dart';

class TodoScreen extends CubitScreen<TodoCubit, DataState> {
  const TodoScreen({super.key});

  @override
  String get name => 'Todo';

  @override
  void Function(TodoCubit cubit)? get onInit => (cubit) => cubit.load();

  @override
  Widget? get floatingActionButton => Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => _showAddDialog(context),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );

  Future<void> _showAddDialog(BuildContext context) async {
    final controller = TextEditingController();
    await showDialog<TodoItem>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New todo'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Title'),
          onSubmitted: (_) =>
              Navigator.pop(context, TodoItem(name: controller.text)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(
                context, TodoItem(name: controller.text, validated: false)),
            child: const Text('Add'),
          ),
        ],
      ),
    ).then((TodoItem? value) {
      if (value != null) {
        cubit.createTodo(value);
      }
    });
  }

  @override
  Widget buildPage(BuildContext context, DataState state) => switch (state) {
        Initial() || Loading() => const Center(
            child: CircularProgressIndicator(),
          ),
        Error(message: final message) => Center(
            child: Text(message, style: AppTheme.textTheme.bodyMedium),
          ),
        Loaded<TodoLoadDto>(data: final data) =>
          TodoContent(todos: data.todos, categories: data.categories),
        _ => const SizedBox.shrink(),
      };
}

class TodoContent extends StatefulWidget {
  const TodoContent({super.key, required this.todos, required this.categories});

  final List<TodoItem> todos;
  final List<TodoCategory> categories;

  @override
  State<TodoContent> createState() => _TodoContentState();
}

class _TodoContentState extends State<TodoContent> {
  int? selectedCategoryId;
  List<TodoItem> filteredTodos = [];

  @override
  void initState() {
    super.initState();
    print(widget.categories);
    filteredTodos = widget.todos;
  }

  @override
  Widget build(BuildContext context) => ListView(
    scrollDirection: Axis.vertical,
    children: [
        widget.categories.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DropdownButton<int>(
                  value: selectedCategoryId,
                  onChanged: (selectedCategory) {
                    setState(() {
                      selectedCategoryId = selectedCategory;
                      filteredTodos = widget.todos
                          .where((todo) => todo.categoryId == selectedCategory)
                          .toList();
                    });
                  },
                  items: widget.categories
                      .map((category) => DropdownMenuItem<int>(
                            value: category.id,
                            child: Text(category.name),
                          ))
                      .toList(),
                ))
            : Text('No categories'),
        filteredTodos.isNotEmpty
            ? ListView.separated(
                itemCount: filteredTodos.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) => CustomContainer(
                  small: true,
                  child: Text(filteredTodos[index].name),
                ),
              )
            : Text('No todos'),
      ]);
}
