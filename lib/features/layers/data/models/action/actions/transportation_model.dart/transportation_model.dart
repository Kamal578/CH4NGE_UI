import 'package:ch4nge/features/layers/data/models/action/action_dto/action_dto.dart';
import 'package:ch4nge/features/layers/domain/entities/action/transportation_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transportation_model.freezed.dart';
part 'transportation_model.g.dart';

@freezed
abstract class TransportationModel with _$TransportationModel {
  const factory TransportationModel({
    required String option,
    required String vehicle,
    required List<double> location,
    required double distance,
    required double duration,
    required String distanceUnit,
    required String durationUnit,
    String? fuelType,
    double? fuelConsumption,
    String? fuelConsumptionUnit,
    int? numberOfPassengers,
    String? publicTransportType,
  }) = _TransportationModel;

    // Factory constructor from TransportationEntity
  factory TransportationModel.fromEntity(TransportationEntity entity) {
    return TransportationModel(
      option: entity.option,
      vehicle: entity.vehicle,
      location: entity.location,
      distance: entity.distance,
      duration: entity.duration,
      distanceUnit: entity.distanceUnit,
      durationUnit: entity.durationUnit,
      fuelType: entity.fuelType,
      fuelConsumption: entity.fuelConsumption,
      fuelConsumptionUnit: entity.fuelConsumptionUnit,
      numberOfPassengers: entity.numberOfPassengers,
      publicTransportType: entity.publicTransportType,
    );
  }

  // Convert to TransportationEntity
  TransportationEntity toEntity() {
    return TransportationEntity(
      option: option,
      vehicle: vehicle,
      location: location,
      distance: distance,
      duration: duration,
      distanceUnit: distanceUnit,
      durationUnit: durationUnit,
      fuelType: fuelType,
      fuelConsumption: fuelConsumption,
      fuelConsumptionUnit: fuelConsumptionUnit,
      numberOfPassengers: numberOfPassengers,
      publicTransportType: publicTransportType,
    );
  }

  // Convert to ActionDTO with all transportation-specific fields
  ActionDTO toActionDTO() {
    final Map<String, dynamic> payload = {
      'option': option,
      'vehicle': vehicle,
      'location': location,
      'distance': distance,
      'duration': duration,
      'distanceUnit': distanceUnit,
      'durationUnit': durationUnit,
    };

    // Add optional fields only if they are not null
    if (fuelType != null) payload['fuelType'] = fuelType;
    if (fuelConsumption != null) payload['fuelConsumption'] = fuelConsumption;
    if (fuelConsumptionUnit != null) payload['fuelConsumptionUnit'] = fuelConsumptionUnit;
    if (numberOfPassengers != null) payload['numberOfPassengers'] = numberOfPassengers;
    if (publicTransportType != null) payload['publicTransportType'] = publicTransportType;

    return ActionDTO(
      actionType: 'transportation',
      payload: payload,
      metadata: {
        'transportMode': option,
        'isEcoFriendly': toEntity().isEcoFriendly,
        'estimatedCO2Emissions': toEntity().estimatedCO2Emissions,
        'transportModeDisplay': toEntity().transportModeDisplay,
      },
    );
  }

  factory TransportationModel.fromJson(Map<String, dynamic> json) =>
      _$TransportationModelFromJson(json);
}