import 'package:flutter/material.dart';
import 'package:mybend/src/shared/extentions.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, this.child, this.selected = true});
  final Widget? child;
  final bool selected;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.them.colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: selected
              ? const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, 4),
              blurRadius: 2,
              spreadRadius: 2,
            )
                ]
              : null,
        ),
        child: child ?? const SizedBox.shrink(),
      );
}
