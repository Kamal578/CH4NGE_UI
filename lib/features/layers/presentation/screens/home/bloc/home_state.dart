part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomaSuccessState extends HomeState {
  final String username;
  final int streak;
  final WeeklyChallengeEntity weeklyChallenge;
  final AchievementEntity achievement;

  const HomaSuccessState(this.username, this.streak, this.weeklyChallenge, this.achievement);

  @override
  List<Object> get props => [username, streak, weeklyChallenge, achievement];
}

final class HomeErrorState extends HomeState {
  final String error;

  const HomeErrorState(this.error);

  @override
  List<Object> get props => [error];
}
