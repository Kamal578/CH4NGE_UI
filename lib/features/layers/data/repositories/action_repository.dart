import 'package:ch4nge/features/layers/data/datasources/action_datasource.dart';
import 'package:ch4nge/features/layers/data/models/action/actions/green_model.dart/green_model.dart';
import 'package:ch4nge/features/layers/data/models/action/actions/transportation_model.dart/transportation_model.dart';
import 'package:ch4nge/features/layers/domain/entities/action/green_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/action/transportation_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/action_repository.dart';
import 'package:either_dart/either.dart';

class ActionRepositoryImpl implements ActionRepository {
  final IActionDatasource datasource;

  ActionRepositoryImpl({required this.datasource});

  @override
  Future<Either<String, String>> uploadGreenAction(GreenEntity action) async {
    try {
      final greenModel = GreenModel.fromEntity(action);

      await datasource.uploadGreenAction(greenModel);

      return Right("Green action uploaded successfully");
    } catch (e) {
      return Left("Failed to upload green action: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, String>> uploadTransportationAction(
      TransportationEntity action) async {
    try {
      final transportationModel = TransportationModel.fromEntity(action);

      await datasource.uploadTransportationAction(transportationModel);

      return Right("Transportation action uploaded successfully");
    } catch (e) {
      return Left("Failed to upload transportation action: ${e.toString()}");
    }
  }
}
