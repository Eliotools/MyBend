import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_category.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_item.dart';
import 'package:mybend/shared/ui/modal_bottom_sheet.dart';

class AlexandrieAddModal extends StatefulWidget {
  const AlexandrieAddModal({super.key, required this.categories});

  final List<AlexandrieCategory> categories;

  @override
  State<AlexandrieAddModal> createState() => _AlexandrieAddModalState();
}

class _AlexandrieAddModalState extends State<AlexandrieAddModal> {
  AlexandrieItem alexandrie = AlexandrieItem.empty();

  @override
  Widget build(BuildContext context) =>
     ModalBottomSheet(
      title: 'Add ',
      children: [
        DropdownMenu<int>(
          label: const Text('Category'),
          expandedInsets: EdgeInsets.zero,
          initialSelection: alexandrie.categoryId,
          dropdownMenuEntries: widget.categories
              .map(
                (category) => DropdownMenuEntry(
                  value: category.id,
                  label: category.name,
                ),
              )
              .toList(),
          onSelected: (value) {
            if (value != null) {
              setState(
                () => alexandrie = alexandrie.copyWith(categoryId: value),
              );
            }
          },
        ),
        const Gap(12),
        TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Title'),
          onChanged: (value) =>
              setState(() => alexandrie = alexandrie.copyWith(question: value)),
        ),
        const Gap(12),
        TextField(
          decoration: const InputDecoration(hintText: 'Description'),
          onChanged: (value) => setState(
            () => alexandrie = alexandrie.copyWith(description: value),
          ),
        ),
        const Gap(16),
        FilledButton(
          onPressed: () => context.pop(alexandrie),
          child: const Text('Add'),
        ),
      ],
    );
}
