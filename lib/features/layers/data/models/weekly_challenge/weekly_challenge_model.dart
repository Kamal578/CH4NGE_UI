import 'package:ch4nge/features/layers/domain/entities/weekly_challenge_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_challenge_model.freezed.dart';
part 'weekly_challenge_model.g.dart';

@freezed
abstract class WeeklyChallengeModel with _$WeeklyChallengeModel {
  const factory WeeklyChallengeModel({
    required int weeklyChallengeId,
    required int userId,
    required String title,
    required String subtitle,
    required double currentValue,
    required double totalValue,
    required int points,
  }) = _WeeklyChallengeModel;

  WeeklyChallengeEntity toEntity() {
    return WeeklyChallengeEntity(
      weeklyChallengeId: weeklyChallengeId,
      userId: userId,
      title: title,
      subtitle: subtitle,
      currentValue: currentValue,
      totalValue: totalValue,
      points: points,
    );
  }

  factory WeeklyChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyChallengeModelFromJson(json);
}
