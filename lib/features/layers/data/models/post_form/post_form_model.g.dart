// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostFormModel _$PostFormModelFromJson(Map<String, dynamic> json) =>
    _PostFormModel(
      userId: json['userId'] as String,
      title: json['title'] as String,
      imageBytes:
          const Uint8ListConverter().fromJson(json['imageBytes'] as String),
      imageName: json['imageName'] as String,
    );

Map<String, dynamic> _$PostFormModelToJson(_PostFormModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'title': instance.title,
      'imageBytes': const Uint8ListConverter().toJson(instance.imageBytes),
      'imageName': instance.imageName,
    };
