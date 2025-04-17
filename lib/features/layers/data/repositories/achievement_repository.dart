import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/achievement_repository.dart';

class AchievementRepositoryImpl implements AchievementRepository {
  @override
  Future<AchievementEntity> getNextAchievement(String userId) async {
    return AchievementEntity(
      achievementId: '1',
      userId: userId,
      title: 'First Achievement',
      subtitle: 'This is your first achievement!',
      isAchieved: false,
    );
  }
}