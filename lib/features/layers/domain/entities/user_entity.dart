import 'package:latlong2/latlong.dart';

class UserEntity {
  final int userId;
  final String username;
  final String email;
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
    required this.profilePicUrl,
    required this.streak,
    required this.points,
    required this.ghgIndex,
    required this.location,
    required this.friendsIds,
  });

  UserEntity copyWith({
    int? userId,
    String? username,
    String? email,
    String? profilePicUrl,
    int? streak,
    int? points,
    double? ghgIndex,
    LatLng? location,
    List<String>? friendsIds,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: email ?? this.email,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      streak: streak ?? this.streak,
      points: points ?? this.points,
      ghgIndex: ghgIndex ?? this.ghgIndex,
      location: location ?? this.location,
      friendsIds: friendsIds ?? this.friendsIds,
    );
  }
}
