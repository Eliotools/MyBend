import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/features/todo/models/todo_category.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/shared/ui/modal_bottom_sheet.dart';
import 'package:mybend/shared/ui/selector.dart';

class TodoAddModal extends StatefulWidget {
  const TodoAddModal({super.key, required this.categories, required this.createCategory});

  final List<TodoCategory> categories;
  final void Function(TodoCategory  value) createCategory;

  @override
  State<TodoAddModal> createState() => _TodoAddModalState();
}

class _TodoAddModalState extends State<TodoAddModal> {
  TodoItem todo = TodoItem.empty();

  @override
  Widget build(BuildContext context) {
    return ModalBottomSheet(
      title: 'Add Todo',
      children: [
        Selector(
          selectedItem: todo.categoryId?.toString() ?? '*',
          items: widget.categories.map((category) => category.name).toList(),
          onSelected: (value) => setState(
              () => todo = todo.copyWith(categoryId: getIdWithCategoryName(value))),
          onAdd: (value) => widget.createCategory(TodoCategory(name: value))
        ),
        const Gap(12),
        TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Title'),
          onChanged: (value) =>
              setState(() => todo = todo.copyWith(name: value)),
        ),
        const Gap(12),
        TextField(
          decoration: const InputDecoration(hintText: 'Description'),
          onChanged: (value) =>
              setState(() => todo = todo.copyWith(description: value)),
        ),
        const Gap(16),
        FilledButton(
          onPressed: () => context.pop(todo),
          child: const Text('Add'),
        ),
      ],
    );
  }

  int getIdWithCategoryName(String value) => widget.categories.firstWhere((c) => c.name == value).id;
}
