// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transportation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransportationModel _$TransportationModelFromJson(Map<String, dynamic> json) =>
    _TransportationModel(
      option: json['option'] as String,
      vehicle: json['vehicle'] as String,
      location: (json['location'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      distance: (json['distance'] as num).toDouble(),
      duration: json['duration'] as String,
      distanceUnit: json['distanceUnit'] as String,
      durationUnit: json['durationUnit'] as String,
    );

Map<String, dynamic> _$TransportationModelToJson(
        _TransportationModel instance) =>
    <String, dynamic>{
      'option': instance.option,
      'vehicle': instance.vehicle,
      'location': instance.location,
      'distance': instance.distance,
      'duration': instance.duration,
      'distanceUnit': instance.distanceUnit,
      'durationUnit': instance.durationUnit,
    };
