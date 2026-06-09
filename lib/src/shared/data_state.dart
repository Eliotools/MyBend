sealed class DataState {
  const DataState();
}

class Initial extends DataState {
  const Initial();
}

class Loading extends DataState {
  const Loading();
}

class Loaded<T> extends DataState {
  const Loaded(this.data);

  final T data;
}

class Error extends DataState {
  const Error(this.message);

  final String message;
}