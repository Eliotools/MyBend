import 'package:flutter/material.dart';
import 'package:mybend/core/extensions/context_extensions.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, this.color, this.child, this.selected = false, this.small = false});

  final Color? color;
  final Widget? child;
  final bool selected;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.all(small ? 2 : 4),
      decoration: BoxDecoration(
        color: selected ? context.colorScheme.primary : color,
        borderRadius: BorderRadius.circular(8),
        border: selected ? Border.all(color : Colors.white, width: 2) : null
      ),
      padding:  EdgeInsets.all(small ? 2 : 8),
      child: child,
    );
  }
}