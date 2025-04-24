import 'package:ch4nge/features/layers/domain/entities/action/green_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/action/transportation_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/action_repository.dart';
import 'package:either_dart/either.dart';

class ActionRepositoryImpl implements ActionRepository {
  @override
  Future<Either<String, String>> uploadGreenAction(GreenEntity action) async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));
    return Right("Green action uploaded successfully");
  }

  @override
  Future<Either<String, String>> uploadTransportationAction(
      TransportationEntity action) async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));
    return Right("Transportation action uploaded successfully");
  }
}
