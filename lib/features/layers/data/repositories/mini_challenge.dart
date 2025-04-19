import 'package:ch4nge/features/layers/domain/entities/mini_challenge_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/mini_challenge_repository.dart';

class MiniChallengeRepositoryImpl implements MiniChallengeRepository {
  @override
  Future<List<MiniChallengeEntity>> getMiniChallenges(String userId) async {
    return [
      MiniChallengeEntity(
          miniChallengeId: '1',
          userId: userId,
          title: 'Stealthy Water Warrior',
          subtitle:
              'Saving 1,000+ l of water in a month through mindful habits',
          isAchieved: false,
          points: 40),
      MiniChallengeEntity(
          miniChallengeId: '1',
          userId: userId,
          title: 'Stealthy Water Warrior',
          subtitle:
              'Saving 1,000+ l of water in a month through mindful habits',
          isAchieved: false,
          points: 40),
      MiniChallengeEntity(
          miniChallengeId: '1',
          userId: userId,
          title: 'Stealthy Water Warrior',
          subtitle:
              'Saving 1,000+ l of water in a month through mindful habits',
          isAchieved: false,
          points: 40),
      MiniChallengeEntity(
          miniChallengeId: '1',
          userId: userId,
          title: 'Stealthy Water Warrior',
          subtitle:
              'Saving 1,000+ l of water in a month through mindful habits',
          isAchieved: false,
          points: 40),
      MiniChallengeEntity(
          miniChallengeId: '1',
          userId: userId,
          title: 'Stealthy Water Warrior',
          subtitle:
              'Saving 1,000+ l of water in a month through mindful habits',
          isAchieved: false,
          points: 40),
      MiniChallengeEntity(
          miniChallengeId: '1',
          userId: userId,
          title: 'Stealthy Water Warrior',
          subtitle:
              'Saving 1,000+ l of water in a month through mindful habits',
          isAchieved: false,
          points: 40),
    ];
  }
}
