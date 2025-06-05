// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostFormModel _$PostFormModelFromJson(Map<String, dynamic> json) =>
    _PostFormModel(
      userId: (json['userId'] as num).toInt(),
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      imageName: json['imageName'] as String,
    );

Map<String, dynamic> _$PostFormModelToJson(_PostFormModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'imageName': instance.imageName,
    };
