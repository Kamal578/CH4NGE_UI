import 'package:ch4nge/features/layers/data/datasources/achievement_datasource.dart';
import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/achievement_repository.dart';

class AchievementRepositoryImpl implements AchievementRepository {
  final IAchievementsDatasource _datasource;

  AchievementRepositoryImpl({
    required IAchievementsDatasource datasource,
  }) : _datasource = datasource;

  // TODO: Uncomment when API is ready
  // @override
  // Future<List<AchievementEntity>> getAllAchievements(String userId) async {
  //   try {
  //     return await _datasource.getAllAchievements(userId);
  //   } catch (e) {
  //     throw Exception('Failed to fetch achievements');
  //   }
  // }
  
  // @override
  // Future<AchievementEntity> getNextAchievement(String userId) async {
  //   try {
  //     return await _datasource.getNextAchievement(userId);
  //   } catch (e) {
  //     throw Exception('Failed to fetch next achievement');
  //   }
  // }

  // @override
  // Future<List<AchievementEntity>> getAchievementProgress(String userId) async {
  //   try {
  //     return await _datasource.getAchievementProgress(userId);
  //   } catch (e) {
  //     throw Exception('Failed to fetch achievement progress');
  //   }
  // }

  // /// Clear all cached achievement data
  // Future<void> clearCache() async {
  //   try {
  //     await _datasource.clearCache();
  //   } catch (e) {
  //     throw Exception('Failed to clear cache');
  //   }
  // }

  @override
  Future<List<AchievementEntity>> getAllAchievements(String userId) async {
    return [
      AchievementEntity(
        achievementId: 1,
        userId: int.parse(userId),
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: true,
      ),
      AchievementEntity(
        achievementId: 2,
        userId: int.parse(userId),
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: true,
      ),
      AchievementEntity(
        achievementId: 1,
        userId: int.parse(userId),
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: true,
      ),
      AchievementEntity(
        achievementId: 2,
        userId: int.parse(userId),
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: true,
      ),
      AchievementEntity(
        achievementId: 1,
        userId: int.parse(userId),
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: 2,
        userId: int.parse(userId),
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: 1,
        userId: int.parse(userId),
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: 2,
        userId: int.parse(userId),
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: 1,
        userId: int.parse(userId),
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: 2,
        userId: int.parse(userId),
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: 1,
        userId: int.parse(userId),
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: 2,
        userId: int.parse(userId),
        title: 'Eco-Friendly Hero',
        subtitle: 'Reducing carbon footprint by 50% in a year',
        isAchieved: false,
      ),
    ];
  }

  @override
  Future<AchievementEntity> getNextAchievement(String userId) async {
    return AchievementEntity(
      achievementId: 1,
        userId: int.parse(userId),
      title: 'Stealthy Water Warrior',
      subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
      isAchieved: false,
    );
  }

  @override
  Future<List<AchievementEntity>> getAchievementProgress(String userId) async {
    return [
      AchievementEntity(
        achievementId: 1,
        userId: int.parse(userId),
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
      AchievementEntity(
        achievementId: 1,
        userId: int.parse(userId),
        title: 'Stealthy Water Warrior',
        subtitle: 'Saving 1,000+ l of water in a month through mindful habits',
        isAchieved: false,
      ),
    ];
  }
}
