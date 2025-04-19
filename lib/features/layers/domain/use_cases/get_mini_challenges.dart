import 'package:ch4nge/features/layers/domain/entities/mini_challenge_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/mini_challenge_repository.dart';

class GetMiniChallengesUseCase {
  final MiniChallengeRepository repository;

  GetMiniChallengesUseCase(this.repository);

  Future<List<MiniChallengeEntity>> call(String userId) async {
    return await repository.getMiniChallenges(userId);
  }
}