import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:either_dart/either.dart';

abstract class ActivityRepository {
  Future<List<ActivityEntity>> getFriendsActivities(List<String> userId);
  Future<Either<String, String>> uploadActivity(ActivityEntity activity);
}
