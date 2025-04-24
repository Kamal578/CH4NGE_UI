import 'package:ch4nge/features/layers/domain/entities/action/green_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/action/transportation_entity.dart';
import 'package:either_dart/either.dart';

abstract class ActionRepository {
  Future<Either<String, String>> uploadGreenAction(GreenEntity action);
  Future<Either<String, String>> uploadTransportationAction(
      TransportationEntity action);
}
