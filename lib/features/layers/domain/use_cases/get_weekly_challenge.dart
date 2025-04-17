import 'package:ch4nge/features/layers/domain/entities/weekly_challenge_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/weekly_challenge_repository.dart';

class GetWeeklyChallengeUseCase {
  final WeeklyChallengeRepository repository;
  GetWeeklyChallengeUseCase(this.repository);
  
  Future<WeeklyChallengeEntity> call(String userId) async {
    return await repository.getWeeklyChallenge(userId);
  }
}