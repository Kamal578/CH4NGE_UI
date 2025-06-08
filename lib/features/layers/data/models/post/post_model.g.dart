// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostModel _$PostModelFromJson(Map<String, dynamic> json) => _PostModel(
      postId: (json['postId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      likedBy: (json['likedBy'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      sharedBy: (json['sharedBy'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      likeNumber: (json['likeNumber'] as num).toInt(),
      sharesNumber: (json['sharesNumber'] as num).toInt(),
    );

Map<String, dynamic> _$PostModelToJson(_PostModel instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'userId': instance.userId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'likedBy': instance.likedBy,
      'sharedBy': instance.sharedBy,
      'likeNumber': instance.likeNumber,
      'sharesNumber': instance.sharesNumber,
    };
