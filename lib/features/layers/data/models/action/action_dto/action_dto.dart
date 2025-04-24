import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_dto.freezed.dart';
part 'action_dto.g.dart';

@freezed
abstract class ActionDTO with _$ActionDTO {
  const factory ActionDTO({
    required String actionType,
    required Map<String, dynamic> payload,
    required Map<String, dynamic> metadata,
  }) = _ActionDTO;

  factory ActionDTO.fromJson(Map<String, dynamic> json) =>
      _$ActionDTOFromJson(json);
}
