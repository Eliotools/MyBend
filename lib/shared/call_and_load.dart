import 'package:mybend/src/shared/data_state.dart';

void callAndLoad<T>(Future<T> Function() call, void Function(DataState) emit,
    {bool silent = false}) async {
  if (!silent) {
    emit(const Loading());
  }
  try {
    final data = await call();
    emit(Loaded<T>(data));
  } catch (e) {
    emit(Error(e.toString()));
  }
}
