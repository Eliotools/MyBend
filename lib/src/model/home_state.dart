
class BendState {
  
  @override
  String toString() => switch (this) {
        BendInitial() => 'Initital',
        BendLoading() => 'Loading',
        BendLoginIn() => 'login',
        BendLoaded(data: final data) => 'LOADED(${data.toString()})',
        BendError(message: final message) => 'Error($message)',
        BendState() => 'Base',
      };

}

class BendInitial extends BendState {}

class BendLoading extends BendState {}

class BendLoginIn extends BendState {}

class BendLoaded<T> extends BendState {
  BendLoaded({required this.data});

  final T data;
}

class BendError extends BendState {
  BendError({required this.message});

  final String message;
}
