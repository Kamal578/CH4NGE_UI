import 'package:ch4nge/features/layers/data/datasources/weekly_challenge_datasource.dart';
import 'package:ch4nge/features/layers/domain/entities/weekly_challenge_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/weekly_challenge_repository.dart';

class WeeklyChallengeRepositoryImpl implements WeeklyChallengeRepository {
  final IWeeklyChallengeDatasource datasource;

  WeeklyChallengeRepositoryImpl({required this.datasource});

  @override
  Future<WeeklyChallengeEntity> getWeeklyChallenge(String userId) async {
    try {
      return await datasource.getWeeklyChallenge(userId);
    } catch (e) {
      throw Exception('Failed to fetch weekly challenge');
    }
  }
}
