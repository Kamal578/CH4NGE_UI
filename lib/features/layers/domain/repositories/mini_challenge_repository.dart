import 'package:ch4nge/features/layers/domain/entities/mini_challenge_entity.dart';

abstract class MiniChallengeRepository {
  Future<List<MiniChallengeEntity>> getMiniChallenges(String userId);
}