import 'package:flutter/material.dart';

class SudokuCell extends StatefulWidget {
  const SudokuCell({super.key, required this.number, required this.selected});

  final int number;
  final bool selected;

  @override
  State<SudokuCell> createState() => _SudokuCellState();
}

class _SudokuCellState extends State<SudokuCell> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: widget.selected ? Colors.red : Colors.blue,
        ),
        child: Text(
          widget.number.toString(),
          textAlign: TextAlign.center,
        ),
      );
}
