import 'package:ch4nge/features/layers/domain/entities/action/action_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/action/green_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/action/transportation_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/action_repository.dart';
import 'package:either_dart/either.dart';

class UploadActionUseCase {
  final ActionRepository repository;

  UploadActionUseCase(this.repository);

  Future<Either<String, String>> call(ActionEntity action) async {
    if (action is GreenEntity) {
      return await repository.uploadGreenAction(action);
    } else if (action is TransportationEntity) {
      return await repository.uploadTransportationAction(action);
    } 
    return Left('Invalid action type');
  }
}