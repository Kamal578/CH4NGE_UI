import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';

class LeaderboardEntry {
  final int rank;
  final String name;
  final int points;
  final String profilePicUrl;
  final bool isCurrentUser;

  LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.points,
    required this.profilePicUrl,
    this.isCurrentUser = false,
  });
}

extension LeaderboardConverter on UserEntity {
  LeaderboardEntry toLeaderboardEntry({
    required int rank,
    required String currentUserId,
  }) {
    return LeaderboardEntry(
      rank: rank,
      name: username,
      points: points,
      profilePicUrl: profilePicUrl,
      isCurrentUser: userId == currentUserId,
    );
  }
}

List<LeaderboardEntry> convertToLeaderboard(
  List<UserEntity> users,
  String currentUserId,
) {
  return users.asMap().entries.map((entry) {
    final index = entry.key + 1;
    return entry.value.toLeaderboardEntry(
      rank: index,
      currentUserId: currentUserId,
    );
  }).toList();
}