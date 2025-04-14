// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostModel _$PostModelFromJson(Map<String, dynamic> json) => _PostModel(
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      commentIds: (json['commentIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      likeNumber: (json['likeNumber'] as num).toInt(),
      sharesNumber: (json['sharesNumber'] as num).toInt(),
    );

Map<String, dynamic> _$PostModelToJson(_PostModel instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'userId': instance.userId,
      'commentIds': instance.commentIds,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'likeNumber': instance.likeNumber,
      'sharesNumber': instance.sharesNumber,
    };
