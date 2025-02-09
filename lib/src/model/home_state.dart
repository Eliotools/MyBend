import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  @override
  @override
  String toString() => switch (this) {
        HomeInitial() => 'Initital',
        HomeLoading() => 'Loading',
        HomeLoginIn() => 'login',
        HomeLoaded(data: final data) => 'LOADED(${data.toString()})',
        HomeError(message: final message) => 'Error($message)',
        HomeState() => 'Base',
      };
  @override
  List<Object?> get props => throw UnimplementedError();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoginIn extends HomeState {}

class HomeLoaded<T> extends HomeState {
  HomeLoaded({required this.data});

  final T data;
}

class HomeError extends HomeState {
  HomeError({required this.message});

  final String message;
}
