// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'green_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GreenModel _$GreenModelFromJson(Map<String, dynamic> json) => _GreenModel(
      option: json['option'] as String,
      location: (json['location'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$GreenModelToJson(_GreenModel instance) =>
    <String, dynamic>{
      'option': instance.option,
      'location': instance.location,
    };
