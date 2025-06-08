import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';
import 'package:ch4nge/features/layers/data/datasources/user_datasource.dart';
import 'package:either_dart/either.dart';

class UserRepositoryImpl implements UserRepository {
  final IUserDatasource _remoteDatasource;

  UserRepositoryImpl({required IUserDatasource datasource})
      : _remoteDatasource = datasource;

  @override
  Future<Either<String, UserEntity>> getUser(String userId) async {
    try {
      // Fetch from datasource (which handles its own caching)
      final userEntity = await _remoteDatasource.getUser(userId);

      return Right(userEntity);
    } catch (e) {
      throw Exception('Failed to fetch user: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<UserEntity>>> getAllUsers() async {
    try {
      final userEntities = await _remoteDatasource.getAllUsers();

      return Right(userEntities);
    } catch (e) {
      throw Exception('Failed to fetch all users: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<UserEntity>>> getFriends(String userId) async {
    try {
      final friendEntities = await _remoteDatasource.getFriends(userId);

      return Right(friendEntities);
    } catch (e) {
      throw Exception('Failed to fetch friends: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, String>> updateFriends(
      String userId, List<String> friendIds) async {
    try {
      await _remoteDatasource.updateFriends(userId, friendIds);

      return const Right('Friends updated successfully');
    } catch (e) {
      return Left('Failed to update friends: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, String>> updateProfilePic(
      String userId, String imagePath) async {
    try {
      final newProfilePicUrl =
          await _remoteDatasource.updateProfilePic(userId, imagePath);

      return Right('Profile picture updated successfully: $newProfilePicUrl');
    } catch (e) {
      return Left('Failed to update profile picture: ${e.toString()}');
    }
  }
}
