import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser(String userId);
  Future<List<UserEntity>> getAllUsers();
}