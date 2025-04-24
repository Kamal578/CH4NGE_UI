import 'package:ch4nge/features/layers/data/models/action/action_dto/action_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transportation_model.freezed.dart';
part 'transportation_model.g.dart';

@freezed
abstract class TransportationModel with _$TransportationModel {
  const factory TransportationModel({
    required String option,
    required String vehicle, // "car", "bus", etc
    required List<double> location,
    required double distance,
    required String duration,
    required String distanceUnit,
    required String durationUnit,
  }) = _TransportationModel;

  ActionDTO toActionDTO() {
    return ActionDTO(
      actionType: 'transportation',
      payload: {
        'option': option,
        'vehicle': vehicle,
        'location': location,
        'distance': distance,
        'duration': duration,
        'distanceUnit': distanceUnit,
        'durationUnit': durationUnit,
      },
      metadata: {},
    );
  }

  factory TransportationModel.fromJson(Map<String, dynamic> json) =>
      _$TransportationModelFromJson(json);
}
