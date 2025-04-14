import 'package:latlong2/latlong.dart';

class ActivityEntity {
  ActivityEntity({
    required this.userId,
    required this.location,
    required this.title,
    required this.value,
  });

  final String userId;
  final LatLng location;
  final String title;
  final int value;
}
