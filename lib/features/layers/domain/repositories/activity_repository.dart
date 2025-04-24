import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';

abstract class ActivityRepository {
  Future<List<ActivityEntity>> getFriendsActivities(List<String> userId);
}
