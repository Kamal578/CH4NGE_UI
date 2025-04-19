import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';

class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase(this.repository);

  Future<List<UserEntity>> call() async {
    final users = await repository.getAllUsers();
    final sortedUsers = users
      ..sort((a, b) => b.points.compareTo(a.points));
    return sortedUsers;
  }
}