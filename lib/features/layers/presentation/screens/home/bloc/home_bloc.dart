import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/weekly_challenge_entity.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_next_achievement.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_user.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_weekly_challenge.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomePageBloc extends Bloc<HomeEvent, HomeState> {
  HomePageBloc(
    this.getUserUseCase,
    this.getWeeklyChallengeUseCase,
    this.getNextAchievementUseCase,
  ) : super(HomeInitialState()) {
    on<HomeStarted>(_onHomeStarted);
  }
  GetUserUseCase getUserUseCase;
  GetWeeklyChallengeUseCase getWeeklyChallengeUseCase;
  GetNextAchievementUseCase getNextAchievementUseCase;

  void _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final String userId = event.userId;
      final UserEntity user = await getUserUseCase(event.userId);
      final String username = user.username;
      final int streak = user.streak;
      final WeeklyChallengeEntity weeklyChallenge =
          await getWeeklyChallengeUseCase(event.userId);
      final AchievementEntity achievement =
          await getNextAchievementUseCase(event.userId);

      emit(HomaSuccessState(
          userId, username, streak, weeklyChallenge, achievement));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
}
