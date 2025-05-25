import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';
import 'package:either_dart/either.dart';

class GetUserUseCase {
  final UserRepository repository;
  GetUserUseCase(this.repository);
  
  Future<Either<String, UserEntity>> call(String userId) async {
    return await repository.getUser(userId);
  }
}