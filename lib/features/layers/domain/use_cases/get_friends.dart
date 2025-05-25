import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';
import 'package:either_dart/either.dart';

class GetFriendsUseCase {
  final UserRepository repository;

  GetFriendsUseCase(this.repository);

  Future<Either<String, List<UserEntity>>> call(String userId) async {
    final friendsData = await repository.getFriends(userId);
    if (friendsData.isRight) {
      final friends = friendsData.right;
      final sortedFriends = friends..sort((a, b) => b.points.compareTo(a.points));
      return Right(sortedFriends);
    } else {
      return Left(friendsData.left);
    }
  }
}
