import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';

class GetFriendsUseCase {
  final UserRepository repository;

  GetFriendsUseCase(this.repository);

  Future<List<UserEntity>> call(String userId) async {
    return await repository.getFriends(userId);
  }
}
