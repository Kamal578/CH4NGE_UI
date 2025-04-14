import 'package:ch4nge/features/layers/domain/entities/mini_challenge_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mini_challenge_model.freezed.dart';
part 'mini_challenge_model.g.dart';

@freezed
abstract class MiniChallengeModel with _$MiniChallengeModel {
  const factory MiniChallengeModel({
    required String miniChallengeId,
    required String userId,
    required String title,
    required String subtitle,
    required bool isAchieved,
    required int points,
  }) = _MiniChallengeModel;

  MiniChallengeEntity toEntity() {
    return MiniChallengeEntity(
      miniChallengeId: miniChallengeId,
      userId: userId,
      title: title,
      subtitle: subtitle,
      isAchieved: isAchieved,
      points: points,
    );
  }

  factory MiniChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$MiniChallengeModelFromJson(json);
}
