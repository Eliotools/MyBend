import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mybend/core/themes/glass_theme.dart';
import 'package:mybend/core/themes/minimal_theme.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.color,
    this.child,
    this.selected = false,
    this.small = false,
  });

  final Color? color;
  final Widget? child;
  final bool selected;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final glass = context.glassTheme;
    final minimal = context.minimalTheme;
    final radius = BorderRadius.circular(small ? 8 : 12);
    final margin = EdgeInsets.all(small ? 2 : 4);

    if (glass?.isGlass ?? false) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(small ? 12 : 16),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: glass!.blurSigma,
            sigmaY: glass.blurSigma,
          ),
          child: Container(
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(small ? 12 : 16),
              color: color ?? glass.fillColor,
              border: Border.all(
                color: glass.borderColor.withAlpha(selected ? 180 : 100),
                width: selected ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(small ? 4 : 8),
            child: child,
          ),
        ),
      );
    }

    if (minimal?.isMinimal ?? false) {
      return Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: radius,
          color: color ?? Colors.white,
          border: Border.all(
            color: selected
                ? const Color(0xFF111111)
                : const Color(0xFFE5E7EB),
            width: selected ? 1.5 : 1,
          ),
        ),
        padding: EdgeInsets.all(small ? 4 : 8),
        child: child,
      );
    }

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Card(
          margin: margin,
          child: child,
        ),
      ),
    );
  }
}
