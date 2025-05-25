import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';
import 'package:either_dart/either.dart';

class UpdateFriendsUseCase {
  final UserRepository repository;

  UpdateFriendsUseCase(this.repository);

  Future<Either<String, String>> call(String userId, List<String> friendIds) async {
    return await repository.updateFriends(userId, friendIds);
  }
}