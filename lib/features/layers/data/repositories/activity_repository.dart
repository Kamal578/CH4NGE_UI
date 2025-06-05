import 'package:ch4nge/features/layers/data/datasources/activity_datasource.dart';
import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/activity_repository.dart';

List<ActivityEntity> activities = [
  ActivityEntity(
    activityId: 1,
    userId: 12345,
    title: 'Walked to work.',
    value: 12,
  ),
  ActivityEntity(
    activityId: 2,
    userId: 12345,
    title: 'Recycled plastic.',
    value: 8,
  ),
  ActivityEntity(
    activityId: 3,
    userId: 12345,
    title: 'Used public transport.',
    value: 10,
  ),

  // Activities for Kamal
  ActivityEntity(
    activityId: 4,
    userId: 12346,
    title: 'Planted a tree.',
    value: 15,
  ),
  ActivityEntity(
    activityId: 5,
    userId: 12346,
    title: 'Turned off lights.',
    value: 5,
  ),
  ActivityEntity(
    activityId: 6,
    userId: 12346,
    title: 'Rode a bike.',
    value: 10,
  ),

  // Activities for Pavel
  ActivityEntity(
    activityId: 7,
    userId: 12347,
    title: 'Took a long flight.',
    value: -25,
  ),
  ActivityEntity(
    activityId: 8,
    userId: 12347,
    title: 'Recycled paper.',
    value: 7,
  ),
  ActivityEntity(
    activityId: 9,
    userId: 12347,
    title: 'Used reusable bags.',
    value: 5,
  ),

  // Activities for Rena
  ActivityEntity(
    activityId: 10,
    userId: 12348,
    title: 'Walked to the grocery store.',
    value: 10,
  ),
  ActivityEntity(
    activityId: 11,
    userId: 12348,
    title: 'Drove to work.',
    value: -12,
  ),
  ActivityEntity(
    activityId: 12,
    userId: 12348,
    title: 'Turned off appliances.',
    value: 6,
  ),

  // Activities for Suad
  ActivityEntity(
    activityId: 13,
    userId: 12349,
    title: 'Used solar panels.',
    value: 20,
  ),
  ActivityEntity(
    activityId: 14,
    userId: 12349,
    title: 'Carpooled to work.',
    value: 12,
  ),
  ActivityEntity(
    activityId: 15,
    userId: 12349,
    title: 'Composted food waste.',
    value: 8,
  ),
];

class ActivityRepositoryImpl implements ActivityRepository {
  final IActivityDatasource datasource;

  ActivityRepositoryImpl({required this.datasource});

  // TODO: Uncomment when API is ready
  // @override
  // Future<List<ActivityEntity>> getFriendsActivities(
  //     List<String> userIds) async {
  //   try {
  //     // Try to get data from datasource (which will check cache first, then API)
  //     return await datasource.getFriendsActivities(userIds);
  //   } catch (e) {
  //     throw Exception('Failed to fetch friends activities');
  //   }
  // }

  @override
  Future<List<ActivityEntity>> getFriendsActivities(
      List<String> userIds) async {
    return Future.value(activities);
  }
}
