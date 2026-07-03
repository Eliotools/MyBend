import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/features/todo/todo_add_modal.dart';
import 'package:mybend/features/todo/todo_cubit.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.todo});

  final TodoItem todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        todo.validated ? Icons.check_circle : Icons.circle_outlined,
        color: todo.categoryId.isNull ? Colors.blue : null,
      ),
      title: Text(todo.name),
      subtitle: todo.description?.isNotEmpty ?? false
          ? Text(todo.description!,
              maxLines: 2, overflow: TextOverflow.ellipsis)
          : null,
      onLongPress: () => todo.validated
          ? context.read<TodoCubit>().archiveTodo(todo)
          : showModalBottomSheet<TodoItem?>(
              isScrollControlled: true,
              context: context,
              builder: (_) => BlocProvider.value(
                  value: context.read<TodoCubit>(),
                  child: TodoAddModal(todo: todo)),
            ).then((value) => value != null
              ? context.read<TodoCubit>().updateTodo(value)
              : null),
      onTap: () => context
          .read<TodoCubit>()
          .updateTodo(todo.copyWith(validated: !todo.validated)),
    );
  }
}
