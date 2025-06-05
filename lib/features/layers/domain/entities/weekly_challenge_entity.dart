class WeeklyChallengeEntity{
  WeeklyChallengeEntity({
    required this.weeklyChallengeId,
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.currentValue,
    required this.totalValue,
    required this.points,
  });

  final int weeklyChallengeId;
  final int userId;
  final String title;
  final String subtitle;
  final double currentValue;
  final double totalValue;
  final int points;
}