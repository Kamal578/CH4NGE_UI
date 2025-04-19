import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/achievement_repository.dart';

class GetAllAchievementsUseCase {
  final AchievementRepository repository;

  GetAllAchievementsUseCase(this.repository);

  Future<List<AchievementEntity>> call(String userId) async {
    return await repository.getAllAchievements(userId);
  }
}
