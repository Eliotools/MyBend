import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/features/todo/todo_cubit.dart';
import 'package:mybend/features/todo/models/todo_item.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.todo});

  final TodoItem todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        todo.validated ? Icons.check_circle : Icons.circle_outlined,
      ),
      title: Text(todo.name),
      subtitle: todo.description?.isNotEmpty ?? false
          ? Text(todo.description!)
          : null,
      onLongPress: () => context.read<TodoCubit>().archiveTodo(todo),
      onTap: () => context
          .read<TodoCubit>()
          .updateTodo(todo.copyWith(validated: !todo.validated)),
    );
  }
}
