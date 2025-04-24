class ActivityEntity {
  ActivityEntity({
    required this.activityId,
    required this.userId,
    required this.title,
    required this.value,
  });

  final String activityId;
  final String userId;
  final String title;
  final int value;
}
