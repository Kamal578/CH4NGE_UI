import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/activity_repository.dart';
import 'package:either_dart/either.dart';

class UploadActivityUseCase {
  final ActivityRepository repository;

  UploadActivityUseCase(this.repository);

  Future<Either<String, String>> call(ActivityEntity activity) async {
    return await repository.uploadActivity(activity);
  }
}