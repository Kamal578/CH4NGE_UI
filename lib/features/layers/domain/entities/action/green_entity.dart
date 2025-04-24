import 'package:ch4nge/features/layers/domain/entities/action/action_entity.dart';

class GreenEntity implements ActionEntity {
  GreenEntity({
    required this.option,
    required this.location,
  });

  @override
  final String option;
  @override
  final List<double> location;
}
