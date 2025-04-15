part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeStarted extends HomeEvent {
  final String userId;

  const HomeStarted(this.userId);

  @override
  List<Object> get props => [userId];
}