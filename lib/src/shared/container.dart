import 'package:flutter/material.dart';
import 'package:mybend/src/shared/custom_color_scheme.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child,
    this.selected = true,
    this.colorIndex,
  });

  final Widget? child;
  final bool selected;
  final int? colorIndex;

  

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: CustomColorScheme.defaultScheme.at(colorIndex ?? 0),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: child ?? const SizedBox.shrink(),
      );
}
