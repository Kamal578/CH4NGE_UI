import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:either_dart/either.dart';

abstract class UserRepository {
  Future<Either<String, UserEntity>> getUser(String userId);
  Future<Either<String, List<UserEntity>>> getAllUsers();
  Future<Either<String, List<UserEntity>>> getFriends(String userId);
  Future<Either<String, String>> updateFriends(String userId, List<String> friendIds);
  Future<Either<String, String>> updateProfilePic(String userId, String imagePath);
}