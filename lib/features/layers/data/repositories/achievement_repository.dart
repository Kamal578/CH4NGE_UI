import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/achievement_repository.dart';

class AchievementRepositoryImpl implements AchievementRepository {
  @override
  Future<AchievementEntity> getNextAchievement(String userId) async {
    return AchievementEntity(
      achievementId: '1',
      userId: userId,
      title: 'Stealthy Water Warrior',
      subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
      isAchieved: false,
    );
  }

  @override
  Future<List<AchievementEntity>> getAchievementProgress(String userId) async {
    return [
      AchievementEntity(
        achievementId: '1',
        userId: userId,
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: '1',
        userId: userId,
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
    ];
  }
}
