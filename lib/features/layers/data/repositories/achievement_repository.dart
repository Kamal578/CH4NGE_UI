import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/achievement_repository.dart';

class AchievementRepositoryImpl implements AchievementRepository {
  @override
  Future<List<AchievementEntity>> getAllAchievements(String userId) async {
    return [
      AchievementEntity(
        achievementId: '1',
        userId: userId,
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: true,
      ),
      AchievementEntity(
        achievementId: '2',
        userId: userId,
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: true,
      ),
      AchievementEntity(
        achievementId: '1',
        userId: userId,
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: true,
      ),
      AchievementEntity(
        achievementId: '2',
        userId: userId,
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: true,
      ),
      AchievementEntity(
        achievementId: '1',
        userId: userId,
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: '2',
        userId: userId,
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: '1',
        userId: userId,
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: '2',
        userId: userId,
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: '1',
        userId: userId,
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: '2',
        userId: userId,
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: '1',
        userId: userId,
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: '2',
        userId: userId,
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: false,
      ),
    ];
  }

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
