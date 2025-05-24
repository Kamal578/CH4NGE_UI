import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_form_model.freezed.dart';
part 'post_form_model.g.dart';

@freezed
abstract class PostFormModel with _$PostFormModel {
  const factory PostFormModel({
    required String userId,
    required String title,
    required String imageUrl,

    required String imageName,
  }) = _PostFormModel;

  factory PostFormModel.fromJson(Map<String, dynamic> json) =>
      _$PostFormModelFromJson(json);
}