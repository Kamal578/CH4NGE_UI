// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mini_challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MiniChallengeModel _$MiniChallengeModelFromJson(Map<String, dynamic> json) =>
    _MiniChallengeModel(
      miniChallengeId: (json['miniChallengeId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      isAchieved: json['isAchieved'] as bool,
      points: (json['points'] as num).toInt(),
    );

Map<String, dynamic> _$MiniChallengeModelToJson(_MiniChallengeModel instance) =>
    <String, dynamic>{
      'miniChallengeId': instance.miniChallengeId,
      'userId': instance.userId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'isAchieved': instance.isAchieved,
      'points': instance.points,
    };
