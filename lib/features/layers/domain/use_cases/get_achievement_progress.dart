import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/achievement_repository.dart';

class GetAchievementProgressUseCase {
  final AchievementRepository repository;

  GetAchievementProgressUseCase(this.repository);

  Future<List<AchievementEntity>> call(String userId) async {
    return await repository.getAchievementProgress(userId);
  }
}