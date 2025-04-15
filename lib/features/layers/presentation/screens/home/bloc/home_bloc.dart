import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/weekly_challenge_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomePageBloc extends Bloc<HomeEvent, HomeState> {
  HomePageBloc() : super(HomeInitialState()) {
    on<HomeStarted>(_onHomeStarted);
  }

  void _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      // Simulate fetching data
      await Future.delayed(const Duration(seconds: 2));
      // Replace with actual data fetching logic
      final String userId = event.userId;
      final UserEntity user = getUserUseCase(userId: userId);
      final String username = user.username;
      final int streak = user.streak;
      final WeeklyChallengeEntity weeklyChallenge = getWeeklyChallengeUseCase(userId: userId);
      final AchievementEntity achievement = getNextAchievementUseCase(userId: userId);

      emit(HomaSuccessState(
          userId, username, streak, weeklyChallenge, achievement));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
}
