import 'package:ch4nge/features/layers/data/datasources/weekly_challenge_datasource.dart';
import 'package:ch4nge/features/layers/domain/entities/weekly_challenge_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/weekly_challenge_repository.dart';

class WeeklyChallengeRepositoryImpl implements WeeklyChallengeRepository {
  final IWeeklyChallengeDatasource datasource;

  WeeklyChallengeRepositoryImpl({required this.datasource});

  // TODO: Uncomment when API is ready
  // @override
  // Future<WeeklyChallengeEntity> getWeeklyChallenge(String userId) async {
  //   try {
  //     return await datasource.getWeeklyChallenge(userId);
  //   } catch (e) {
  //     throw Exception('Failed to fetch weekly challenge');
  //   }
  // }

  @override
  Future<WeeklyChallengeEntity> getWeeklyChallenge(String userId) async {
    return WeeklyChallengeEntity(
      weekklyChallengeId: '1',
      userId: userId,
      title: 'Pedal Power Challenge',
      subtitle: '75 KM on a bicycle in 7 Days!',
      currentValue: 3,
      totalValue: 5,
      points: 20,
    );
  }
}
