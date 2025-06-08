import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
abstract class PostModel with _$PostModel {
  const factory PostModel({
    required int postId,
    required int userId,
    required String title,
    required String imageUrl,
    required List<int> likedBy,
    required List<int> sharedBy,
    required int likeNumber,
    required int sharesNumber,
  }) = _PostModel;

  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      userId: userId,
      title: title,
      imageUrl: imageUrl,
      likedBy: likedBy,
      sharedBy: sharedBy,
      likeNumber: likeNumber,
      sharesNumber: sharesNumber,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
