// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    _ActivityModel(
      activityId: json['activityId'] as String,
      userId: json['userId'] as String,
      location: (json['location'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      title: json['title'] as String,
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$ActivityModelToJson(_ActivityModel instance) =>
    <String, dynamic>{
      'activityId': instance.activityId,
      'userId': instance.userId,
      'location': instance.location,
      'title': instance.title,
      'value': instance.value,
    };
