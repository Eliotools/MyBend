import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mybend/core/extensions/context_extensions.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, this.color, this.child, this.selected = false, this.small = false});

  final Color? color;
  final Widget? child;
  final bool selected;
  final bool small;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 20,
        sigmaY: 20
      ),
      child: 
    Container(
        margin:  EdgeInsets.all(small ? 2 : 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [context.colorScheme.primary.withAlpha(51), context.colorScheme.secondary.withAlpha(51)],
           begin: Alignment.topLeft,
      end: Alignment.bottomRight,),
           boxShadow: [
      BoxShadow(
        blurRadius: 20,
        spreadRadius: 0,
        color: Colors.black.withAlpha(10),
      ),
    ],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color :  Colors.white.withAlpha(selected ? 100 : 60), width: 2) 
        ),
        padding:  EdgeInsets.all(small ? 2 : 8),
        child: child,
      ),),
  );
}