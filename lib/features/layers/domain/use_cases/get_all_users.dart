import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';
import 'package:either_dart/either.dart';

class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase(this.repository);

  Future<Either<String, List<UserEntity>>> call() async {
    Either<String, List<UserEntity>> usersData = await repository.getAllUsers();
    if (usersData.isRight) {
      final users = usersData.right;
      final sortedUsers = users..sort((a, b) => b.points.compareTo(a.points));
      return Right(sortedUsers);
    } else {
      return Left(usersData.left);
    }
  }
}
