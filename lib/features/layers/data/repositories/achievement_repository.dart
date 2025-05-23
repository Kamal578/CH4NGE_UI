import 'package:ch4nge/features/layers/data/datasources/datasource_achievements.dart';
import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/achievement_repository.dart';

class AchievementRepositoryImpl implements AchievementRepository {
  final IAchievementsDatasource _datasource;

  AchievementRepositoryImpl({
    required IAchievementsDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<List<AchievementEntity>> getAllAchievements(String userId) async {
    try {
      return await _datasource.getAllAchievements(userId);
    } catch (e) {
      throw Exception('Failed to fetch achievements');
    }
  }
  
  @override
  Future<AchievementEntity> getNextAchievement(String userId) async {
    try {
      return await _datasource.getNextAchievement(userId);
    } catch (e) {
      throw Exception('Failed to fetch next achievement');
    }
  }

  @override
  Future<List<AchievementEntity>> getAchievementProgress(String userId) async {
    try {
      return await _datasource.getAchievementProgress(userId);
    } catch (e) {
      throw Exception('Failed to fetch achievement progress');
    }
  }

  /// Clear all cached achievement data
  Future<void> clearCache() async {
    try {
      await _datasource.clearCache();
    } catch (e) {
      throw Exception('Failed to clear cache');
    }
  }
}
