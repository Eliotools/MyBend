import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Selector extends StatefulWidget {
  const Selector({
    super.key,
    required this.items,
    required this.onSelected,
    required this.selectedItem,
    this.onAdd,
  });

  final List<String> items;
  final void Function(String item) onSelected;
  final String selectedItem;
  final void Function(String item)? onAdd;

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  String _newItem = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownMenu<String>(
          initialSelection: widget.selectedItem,
          label: const Text('Category'),
          expandedInsets: EdgeInsets.zero,
          dropdownMenuEntries: [
            const DropdownMenuEntry(value: '*', label: 'All'),
            ...widget.items.map(
              (item) => DropdownMenuEntry(value: item, label: item),
            ),
          ],
          onSelected: (value) {
            if (value != null) widget.onSelected(value);
          },
        ),
        if (widget.onAdd != null) ...[
          const Gap(12),
          TextField(
            decoration: const InputDecoration(
              hintText: 'New category',
            ),
            onChanged: (value) => setState(() => _newItem = value),
            onSubmitted: (_) => _addCategory(),
          ),
          const Gap(12),
          FilledButton.tonal(
            onPressed:
                _newItem.isEmpty ? null : () => widget.onAdd?.call(_newItem),
            child: const Text('Add'),
          ),
        ]
      ],
    );
  }

  void _addCategory() {
    if (_newItem.isEmpty) return;
    widget.onAdd?.call(_newItem.trim());
    setState(() => _newItem = '');
  }
}
