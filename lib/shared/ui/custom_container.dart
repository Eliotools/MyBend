import 'dart:ui';

import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      this.color,
      this.child,
      this.selected = false,
      this.small = false});

  final Color? color;
  final Widget? child;
  final bool selected;
  final bool small;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Card(
            margin: EdgeInsets.all(small ? 2 : 4),
            child: child,
          ),
        ),
      );
}
