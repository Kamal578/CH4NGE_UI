import 'package:ch4nge/features/layers/data/models/action/action_dto/action_dto.dart';
import 'package:ch4nge/features/layers/domain/entities/action/green_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'green_model.freezed.dart';
part 'green_model.g.dart';

@freezed
abstract class GreenModel with _$GreenModel {
  const factory GreenModel({
    required String option, // "planted_tree", "lights_off", etc
    required List<double> location,
  }) = _GreenModel;

  factory GreenModel.fromEntity(GreenEntity entity) {
    return GreenModel(
      option: entity.option,
      location: entity.location,
    );
  }

  GreenEntity toEntity() {
    return GreenEntity(
      option: option,
      location: location,
    );
  }

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
