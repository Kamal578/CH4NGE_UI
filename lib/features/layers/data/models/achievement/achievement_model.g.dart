// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AchievementModel _$AchievementModelFromJson(Map<String, dynamic> json) =>
    _AchievementModel(
      achievementId: json['achievementId'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      isAchieved: json['isAchieved'] as bool,
    );

Map<String, dynamic> _$AchievementModelToJson(_AchievementModel instance) =>
    <String, dynamic>{
      'achievementId': instance.achievementId,
      'userId': instance.userId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'isAchieved': instance.isAchieved,
    };
