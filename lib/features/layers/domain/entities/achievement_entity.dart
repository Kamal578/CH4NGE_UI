class AchievementEntity {
  AchievementEntity({
    required this.achievementId,
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.isAchieved,
  });

  final int achievementId;
  final int userId;
  final String title;
  final String subtitle;
  final bool isAchieved;
}
