import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';

abstract class AchievementRepository {
  Future<AchievementEntity> getNextAchievement(String userId);
  Future<List<AchievementEntity>> getAchievementProgress(String userId);
}