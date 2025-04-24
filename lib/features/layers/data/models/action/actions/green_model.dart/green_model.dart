import 'package:ch4nge/features/layers/data/models/action/action_dto/action_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'green_model.freezed.dart';
part 'green_model.g.dart';

@freezed
abstract class GreenModel with _$GreenModel {
  const factory GreenModel({
    required String option, // "planted_tree", "lights_off", etc
    required List<double> location,
  }) = _GreenModel;

  ActionDTO toActionDTO() {
    return ActionDTO(
      actionType: 'green',
      payload: {
        'option': option,
        'location': location,
      },
      metadata: {},
    );
  }

  factory GreenModel.fromJson(Map<String, dynamic> json) =>
      _$GreenModelFromJson(json);
}