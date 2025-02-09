import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get them => Theme.of(this);
}
