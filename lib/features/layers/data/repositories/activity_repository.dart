import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/activity_repository.dart';
import 'package:latlong2/latlong.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  @override
  Future<List<ActivityEntity>> getFriendsActivities(
      List<String> userIds) async {
    return [
      // Activities for Dima
      ActivityEntity(
        activityId: '1',
        userId: '12345',
        title: 'Walked to work.',
        location: LatLng(40.41766581333585, 49.96498330825312),
        value: 12,
      ),
      ActivityEntity(
        activityId: '2',
        userId: '12345',
        title: 'Recycled plastic.',
        location: LatLng(40.41866581333585, 49.96598330825312),
        value: 8,
      ),
      ActivityEntity(
        activityId: '3',
        userId: '12345',
        title: 'Used public transport.',
        location: LatLng(40.41966581333585, 49.96698330825312),
        value: 10,
      ),

      // Activities for Kamal
      ActivityEntity(
        activityId: '4',
        userId: '12346',
        title: 'Planted a tree.',
        location: LatLng(40.42066581333585, 49.96798330825312),
        value: 15,
      ),
      ActivityEntity(
        activityId: '5',
        userId: '12346',
        title: 'Turned off lights.',
        location: LatLng(40.42166581333585, 49.96898330825312),
        value: 5,
      ),
      ActivityEntity(
        activityId: '6',
        userId: '12346',
        title: 'Rode a bike.',
        location: LatLng(40.42266581333585, 49.96998330825312),
        value: 10,
      ),

      // Activities for Pavel
      ActivityEntity(
        activityId: '7',
        userId: '12347',
        title: 'Took a long flight.',
        location: LatLng(40.42366581333585, 49.97098330825312),
        value: -25,
      ),
      ActivityEntity(
        activityId: '8',
        userId: '12347',
        title: 'Recycled paper.',
        location: LatLng(40.42466581333585, 49.97198330825312),
        value: 7,
      ),
      ActivityEntity(
        activityId: '9',
        userId: '12347',
        title: 'Used reusable bags.',
        location: LatLng(40.42566581333585, 49.97298330825312),
        value: 5,
      ),

      // Activities for Rena
      ActivityEntity(
        activityId: '10',
        userId: '12348',
        title: 'Walked to the grocery store.',
        location: LatLng(40.42666581333585, 49.97398330825312),
        value: 10,
      ),
      ActivityEntity(
        activityId: '11',
        userId: '12348',
        title: 'Drove to work.',
        location: LatLng(40.42766581333585, 49.97498330825312),
        value: -12,
      ),
      ActivityEntity(
        activityId: '12',
        userId: '12348',
        title: 'Turned off appliances.',
        location: LatLng(40.42866581333585, 49.97598330825312),
        value: 6,
      ),

      // Activities for Suad
      ActivityEntity(
        activityId: '13',
        userId: '12349',
        title: 'Used solar panels.',
        location: LatLng(40.42966581333585, 49.97698330825312),
        value: 20,
      ),
      ActivityEntity(
        activityId: '14',
        userId: '12349',
        title: 'Carpooled to work.',
        location: LatLng(40.43066581333585, 49.97798330825312),
        value: 12,
      ),
      ActivityEntity(
        activityId: '15',
        userId: '12349',
        title: 'Composted food waste.',
        location: LatLng(40.43166581333585, 49.97898330825312),
        value: 8,
      ),
    ];
  }
}
