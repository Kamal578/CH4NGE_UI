class MiniChallengeEntity {
  const MiniChallengeEntity({
    required this.miniChallengeId,
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.isAchieved,
    required this.points,
  });

  final String miniChallengeId;
  final String userId;
  final String title;
  final String subtitle;
  final bool isAchieved;
  final int points;
}
