import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_form_model.freezed.dart';
part 'post_form_model.g.dart';

@freezed
abstract class PostFormModel with _$PostFormModel {
  const factory PostFormModel({
    required int userId,
    required String title,
    required String imageUrl,

    required String imageName,
  }) = _PostFormModel;

  PostFormModel toEntity() {
    return PostFormModel(
      userId: userId,
      title: title,
      imageUrl: imageUrl,
      imageName: imageName,
    );
  }

  factory PostFormModel.fromJson(Map<String, dynamic> json) =>
      _$PostFormModelFromJson(json);
}