import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybend/features/todo/todo_cubit.dart';
import 'package:mybend/features/todo/models/todo_item.dart';
import 'package:mybend/shared/ui/custom_container.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.todo});

  final TodoItem todo;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      small: true,
      child: Row(
        children: [
          GestureDetector(
            onLongPress: () => context.read<TodoCubit>().archiveTodo(todo),
            onDoubleTap: () => context
                .read<TodoCubit>()
                .updateTodo(todo.copyWith(validated: !todo.validated)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                  todo.validated ? Icons.check_circle : Icons.circle_outlined),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todo.name),
              todo.description != null
                  ? Text(todo.description!)
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
