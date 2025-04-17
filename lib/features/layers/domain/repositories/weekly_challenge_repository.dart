import 'package:ch4nge/features/layers/domain/entities/weekly_challenge_entity.dart';

abstract class WeeklyChallengeRepository {
  Future<WeeklyChallengeEntity> getWeeklyChallenge(String userId);
}