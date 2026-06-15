import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class M3Sheet extends StatelessWidget {
  // TODO(refacor): update this to call the parent func
  const M3Sheet({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const Gap(16),
          ...children,
        ],
      ),
    );
  }
}
