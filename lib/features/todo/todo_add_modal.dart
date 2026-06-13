import 'package:flutter/material.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/features/todo/models/todo_category.dart';
import 'package:go_router/go_router.dart';

class TodoAddModal extends StatefulWidget {
  const TodoAddModal({super.key, required this.categories});

  final List<TodoCategory> categories;

  @override
  State<TodoAddModal> createState() => _TodoAddModalState();
}

class _TodoAddModalState extends State<TodoAddModal> {
  TodoItem todo = TodoItem.empty();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Center(child: Text('Add Todo')),
          // TODO(upgrade): check if it's possible to use form
          DropdownButton(
            value: todo.categoryId,
            items: widget.categories
                .map((category) => DropdownMenuItem(
                    value: category.id, child: Text(category.name)))
                .toList(),
            onChanged: (value) =>
                setState(() => todo = todo.copyWith(categoryId: value)),
          ),
          TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Title'),
            onChanged: (value) =>
                setState(() => todo = todo.copyWith(name: value)),
            onSubmitted: (_) => Navigator.pop(context, todo),
          ),
          TextField(
            onChanged: (value) =>
                setState(() => todo = todo.copyWith(description: value)),
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Description'),
            onSubmitted: (_) => Navigator.pop(context, todo),
          ),
          TextButton(
            onPressed: () => context.pop(todo),
            child: const Text('Add'),
          ),
        ],
      );
}
