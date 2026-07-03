import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get them => Theme.of(this);
  ColorScheme get colorScheme => them.colorScheme;

  /// Opens a modal bottom sheet and re-provides [TCubit] to the modal subtree.
  Future<T?> showModalBS<TCubit extends Cubit<Object?>, T>({
    required Widget Function(BuildContext context) builder,
    bool isScrollControlled = true,
  }) {
    final cubit = read<TCubit>();
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      builder: (modalContext) => BlocProvider<TCubit>.value(
        value: cubit,
        child: builder(modalContext),
      ),
    );
  }
}
