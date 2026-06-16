import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class DataState<T> extends Equatable {
  const DataState();
  
  @override
  List<T> get props => [];
}

class Initial<T> extends DataState<T> {


  const Initial();
}

class Loading<T> extends DataState<T> {
  const Loading();
}

@immutable
class Loaded<T> extends DataState<T> {
  const Loaded(this.data);
  
  @override
  List<T> get props => [data];
  
  final T data;
}

class Error<T> extends DataState<T> {
  const Error(this.message);

  final String message;
}
