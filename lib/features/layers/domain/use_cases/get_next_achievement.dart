import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/achievement_repository.dart';

class GetNextAchievementUseCase {
  final AchievementRepository repository;
  GetNextAchievementUseCase(this.repository);
  
  Future<AchievementEntity> call(String userId) async {
    return await repository.getNextAchievement(userId);
  }
}