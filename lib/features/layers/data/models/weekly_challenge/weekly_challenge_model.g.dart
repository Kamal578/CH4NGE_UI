// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeeklyChallengeModel _$WeeklyChallengeModelFromJson(
        Map<String, dynamic> json) =>
    _WeeklyChallengeModel(
      weekklyChallengeId: json['weekklyChallengeId'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      currentValue: (json['currentValue'] as num).toDouble(),
      totalValue: (json['totalValue'] as num).toDouble(),
      points: (json['points'] as num).toInt(),
    );

Map<String, dynamic> _$WeeklyChallengeModelToJson(
        _WeeklyChallengeModel instance) =>
    <String, dynamic>{
      'weekklyChallengeId': instance.weekklyChallengeId,
      'userId': instance.userId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'currentValue': instance.currentValue,
      'totalValue': instance.totalValue,
      'points': instance.points,
    };
