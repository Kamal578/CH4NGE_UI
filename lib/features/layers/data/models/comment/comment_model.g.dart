// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentModel _$CommentModelFromJson(Map<String, dynamic> json) =>
    _CommentModel(
      commentId: json['commentId'] as String,
      userId: json['userId'] as String,
      postId: json['postId'] as String,
      content: json['content'] as String,
      likeNumber: (json['likeNumber'] as num).toInt(),
      sharesNumber: (json['sharesNumber'] as num).toInt(),
    );

Map<String, dynamic> _$CommentModelToJson(_CommentModel instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'userId': instance.userId,
      'postId': instance.postId,
      'content': instance.content,
      'likeNumber': instance.likeNumber,
      'sharesNumber': instance.sharesNumber,
    };
