class ActivityEntity {
  ActivityEntity({
    required this.activityId,
    required this.userId,
    required this.title,
    required this.value,
  });

  final int activityId;
  final int userId;
  final String title;
  final int value;
}
