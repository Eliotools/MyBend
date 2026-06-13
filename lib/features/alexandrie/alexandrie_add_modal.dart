import 'package:flutter/material.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_item.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_category.dart';
import 'package:go_router/go_router.dart';

class AlexandrieAddModal extends StatefulWidget {
  const AlexandrieAddModal({super.key, required this.categories});

  final List<AlexandrieCategory> categories;

  @override
  State<AlexandrieAddModal> createState() => _AlexandrieAddModalState();
}

class _AlexandrieAddModalState extends State<AlexandrieAddModal> {
  AlexandrieItem alexandrie = AlexandrieItem.empty();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Center(child: Text('Add Alexandrie')),
          // Alexandrie(upgrade): check if it's possible to use form
          DropdownButton(
            value: alexandrie.categoryId,
            items: widget.categories
                .map((category) => DropdownMenuItem(
                    value: category.id, child: Text(category.name)))
                .toList(),
            onChanged: (value) => setState(
                () => alexandrie = alexandrie.copyWith(categoryId: value)),
          ),
          TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Title'),
            onChanged: (value) => setState(
                () => alexandrie = alexandrie.copyWith(question: value)),
            onSubmitted: (_) => Navigator.pop(context, alexandrie),
          ),
          TextField(
            onChanged: (value) => setState(
                () => alexandrie = alexandrie.copyWith(description: value)),
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Description'),
            onSubmitted: (_) => Navigator.pop(context, alexandrie),
          ),
          TextButton(
            onPressed: () => context.pop(alexandrie),
            child: const Text('Add'),
          ),
        ],
      );
}
