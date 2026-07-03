import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/features/todo/models/todo_category.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/shared/ui/modal_bottom_sheet.dart';
import 'package:mybend/shared/ui/selector.dart';

class TodoAddModal extends StatefulWidget {
  const TodoAddModal(
      {super.key, this.categories, this.createCategory, this.todo});

  final List<TodoCategory>? categories;
  final void Function(TodoCategory value)? createCategory;
  final TodoItem? todo;

  @override
  State<TodoAddModal> createState() => _TodoAddModalState();
}

class _TodoAddModalState extends State<TodoAddModal> {
  TodoItem todo = TodoItem.empty();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      todo = widget.todo!;
      _nameController.text = widget.todo?.name ?? '';
      _descriptionController.text = widget.todo?.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalBottomSheet(
      title: widget.todo != null ? 'Edit Todo' : 'Add Todo',
      children: [
        if (widget.createCategory != null && widget.categories != null) ...[
          Selector(
              selectedItem: todo.categoryId?.toString() ?? '*',
              items:
                  widget.categories!.map((category) => category.name).toList(),
              onSelected: (value) => setState(() => todo =
                  todo.copyWith(categoryId: getIdWithCategoryName(value))),
              onAdd: (value) =>
                  widget.createCategory!(TodoCategory(name: value))),
          const Gap(12),
        ],
        TextField(
          autofocus: true,
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'Title'),
          onChanged: (value) =>
              setState(() => todo = todo.copyWith(name: value)),
        ),
        const Gap(12),
        TextField(
            maxLines: 5,
            minLines: 1,
            controller: _descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            onChanged: (value) =>
                setState(() => todo = todo.copyWith(description: value))),
        const Gap(16),
        FilledButton(
          onPressed: () => context.pop(todo),
          child: Text(widget.todo != null ? 'Edit' : 'Add'),
        ),
      ],
    );
  }

  //TODO(refactor): update to helper
  int getIdWithCategoryName(String value) =>
      widget.categories!.firstWhere((c) => c.name == value).id;
}
