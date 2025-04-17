import 'package:latlong2/latlong.dart';

class UserEntity {
  final String userId;
  final String username;
  final String email;
  final String password;
  final String profilePicUrl;
  final int streak;
  final int points;
  final double ghgIndex;
  final LatLng location;
  final List<String> friendsIds;

  UserEntity({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.profilePicUrl,
    required this.streak,
    required this.points,
    required this.ghgIndex,
    required this.location,
    required this.friendsIds,
  });
}
