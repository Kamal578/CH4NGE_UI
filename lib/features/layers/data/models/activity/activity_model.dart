import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

@freezed
abstract class ActivityModel with _$ActivityModel {
  const factory ActivityModel({
    required String activityId,
    required String userId,
    required List<double> location,
    required String title,
    required int value,
  }) = _ActivityModel;

  ActivityEntity toEntity() {
    return ActivityEntity(
      activityId: activityId,
      userId: userId,
      location: LatLng(location[0], location[1]),
      title: title,
      value: value,
    );
  }

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);
}
