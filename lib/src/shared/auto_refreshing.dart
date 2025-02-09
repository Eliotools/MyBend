import 'dart:async';

import 'package:flutter/cupertino.dart';

class AutoRefreshing extends StatefulWidget {
  /// Creates an [AutoRefreshing] every [period] as a [Duration] with [builder] content
  ///
  /// Warning: Don't [setState] in [builder]
  AutoRefreshing({required this.period, required this.builder, super.key});

  Duration period;
  Widget Function(BuildContext, AutoRefreshing) builder;

  Timer? refresher;

  @override
  State<AutoRefreshing> createState() => _AutoRefreshingState();
}

class _AutoRefreshingState extends State<AutoRefreshing> {
  @override
  Widget build(BuildContext context) => widget.builder(context, widget);

  @override
  void initState() {
    widget.refresher = Timer.periodic(widget.period, (t) {
      widget.refresher = t;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (widget.refresher != null) {
      widget.refresher!.cancel();
    }
    super.dispose();
  }
}
