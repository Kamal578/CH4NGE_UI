// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActionDTO _$ActionDTOFromJson(Map<String, dynamic> json) => _ActionDTO(
      actionType: json['actionType'] as String,
      payload: json['payload'] as Map<String, dynamic>,
      metadata: json['metadata'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ActionDTOToJson(_ActionDTO instance) =>
    <String, dynamic>{
      'actionType': instance.actionType,
      'payload': instance.payload,
      'metadata': instance.metadata,
    };
