import 'package:mybend/src/shared/data_state.dart';

void callAndLoad<T>(
    Future<T> Function() call, void Function(DataState) emit) async {
  emit(const Loading());
  try {
    final data = await call();
    emit(Loaded<T>(data));
  } catch (e) {
    emit(Error(e.toString()));
  }
}
