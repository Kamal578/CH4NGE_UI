import 'package:ch4nge/features/layers/domain/entities/weekly_challenge_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/weekly_challenge_repository.dart';

class WeeklyChallengeRepositoryImpl implements WeeklyChallengeRepository {
  Future<WeeklyChallengeEntity> getWeeklyChallenge(String userId) async {
    return WeeklyChallengeEntity(
      weekklyChallengeId: '1',
      userId: userId,
      title: 'Weekly Challenge',
      subtitle: 'Complete the weekly challenge to earn rewards.',
      currentValue: 3,
      totalValue: 5,
      points: 20,
    );
  }
}
