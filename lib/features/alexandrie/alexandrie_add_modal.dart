import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_category.dart';
import 'package:mybend/features/alexandrie/models/alexandrie_item.dart';
import 'package:mybend/shared/ui/modal_bottom_sheet.dart';
import 'package:mybend/shared/ui/selector.dart';

class AlexandrieAddModal extends StatefulWidget {
  const AlexandrieAddModal({super.key, required this.categories, required this.createCategory});

  final List<AlexandrieCategory> categories;
  final void Function(AlexandrieCategory  value) createCategory;

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
        Selector(
          selectedItem: alexandrie.categoryId?.toString() ?? '*',
          items: widget.categories.map((category) => category.name).toList(),
          onSelected: (value) => setState(
              () => alexandrie = alexandrie.copyWith(categoryId: getIdWithCategoryName(value))),
          onAdd: (value) => widget.createCategory(AlexandrieCategory(name: value))
        ),
        const Gap(12),
        TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Question'),
          onChanged: (value) =>
              setState(() => alexandrie = alexandrie.copyWith(question: value)),
        ),
        const Gap(12),
        TextField(
          decoration: const InputDecoration(hintText: 'Answer'),
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

  //TODO(refactor): update to helper
  int getIdWithCategoryName(String value) => widget.categories.firstWhere((c) => c.name == value).id;

}
