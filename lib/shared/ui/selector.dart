import 'package:flutter/material.dart';

class Selector extends StatefulWidget {
  const Selector({
    super.key,
    required this.items,
    required this.onSelected,
    required this.selectedItem,
    required this.onAdd,
  });

  final List<String> items;
  final void Function(String item) onSelected;
  final String selectedItem;
  final void Function(String item) onAdd;

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: widget.selectedItem,
        isExpanded: true,
        items: [
          DropdownMenuItem(
            value: '',
            child: SizedBox(
              width: 300,
              child: TextField(
                  controller: _controller,
                  onSubmitted: (value) =>
                      setState(() => widget.onAdd(_controller.text)),
                  decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      isDense: true,
                      hintText: 'Nouvelle catégorie',
                      suffix: IconButton(
                          onPressed: () => widget.onAdd(_controller.text),
                          icon: const Icon(Icons.add)))),
            ),
          ),
          const DropdownMenuItem(value: '*', child: Text('*')),
          ...widget.items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList()
        ],
        onChanged: (value) =>
            setState(() => widget.onSelected(value ?? widget.selectedItem)));
  }
}
