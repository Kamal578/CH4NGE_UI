import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
abstract class CommentModel with _$CommentModel {
  const factory CommentModel({
    required String commentId,
    required String userId,
    required String postId,
    required String content,
    required int likeNumber,
    required int sharesNumber,
  }) = _CommentModel;

  CommentModel toEntity() {
    return CommentModel(
      commentId: commentId,
      userId: userId,
      postId: postId,
      content: content,
      likeNumber: likeNumber,
      sharesNumber: sharesNumber,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
