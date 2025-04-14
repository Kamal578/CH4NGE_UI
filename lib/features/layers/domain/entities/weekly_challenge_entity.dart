class WeeklyChallengeEntity{
  WeeklyChallengeEntity({
    required this.weekklyChallengeId,
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.currentValue,
    required this.totalValue,
    required this.points,
  });

  final String weekklyChallengeId;
  final String userId;
  final String title;
  final String subtitle;
  final double currentValue;
  final double totalValue;
  final int points;
}