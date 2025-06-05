import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement_model.freezed.dart';
part 'achievement_model.g.dart';

@freezed
abstract class AchievementModel with _$AchievementModel {
  const factory AchievementModel({
    required int achievementId,
    required int userId,
    required String title,
    required String subtitle,
    required bool isAchieved,
  }) = _AchievementModel;

  AchievementEntity toEntity() {
    return AchievementEntity(
      achievementId: achievementId,
      userId: userId,
      title: title,
      subtitle: subtitle,
      isAchieved: isAchieved,
    );
  }

  factory AchievementModel.fromJson(Map<String, dynamic> json) =>
      _$AchievementModelFromJson(json);
}
