// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    _ActivityModel(
      activityId: json['activityId'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      points: (json['points'] as num).toInt(),
    );

Map<String, dynamic> _$ActivityModelToJson(_ActivityModel instance) =>
    <String, dynamic>{
      'activityId': instance.activityId,
      'userId': instance.userId,
      'title': instance.title,
      'points': instance.points,
    };
