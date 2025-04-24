import 'package:ch4nge/features/layers/domain/entities/action/action_entity.dart';

class TransportationEntity implements ActionEntity {
  TransportationEntity({
    required this.option,
    required this.vehicle,
    required this.location,
    required this.distance,
    required this.duration,
    required this.distanceUnit,
    required this.durationUnit,
  });

  @override
  final String option;
  final String vehicle;
  @override
  final List<double> location;
  final double distance;
  final String duration;
  final String distanceUnit;
  final String durationUnit;
}
