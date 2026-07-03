import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/features/todo/models/todo_category.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/features/todo/todo_cubit.dart';
import 'package:mybend/shared/ui/modal_bottom_sheet.dart';
import 'package:mybend/shared/ui/selector.dart';

class TodoAddModal extends StatefulWidget {
  const TodoAddModal({super.key, this.todo});

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
  Widget build(BuildContext context) => ModalBottomSheet(
        title: widget.todo != null ? 'Edit Todo' : 'Add Todo',
        children: [
          if (context.read<TodoCubit>().prevState?.categories.isNotEmpty ??
              false) ...[
            Selector(
                selectedItem: todo.categoryId?.toString() ?? '*',
                items: context
                        .read<TodoCubit>()
                        .prevState
                        ?.categories
                        .map((category) => category.name)
                        .toList() ??
                    [],
                onSelected: (value) => setState(() => todo =
                    todo.copyWith(categoryId: getIdWithCategoryName(value))),
                onAdd: (value) => context
                    .read<TodoCubit>()
                    .createCategory(TodoCategory(name: value))),
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

  //TODO(refactor): update to helper
  int getIdWithCategoryName(String value) =>
      context
          .read<TodoCubit>()
          .prevState
          ?.categories
          .firstWhere((c) => c.name == value)
          .id ??
      0;
}
