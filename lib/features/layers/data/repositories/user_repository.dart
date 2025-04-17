import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';
import 'package:latlong2/latlong.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserEntity> getUser(String userId) async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));
    // Replace with actual data fetching logic
    return UserEntity(
      userId: userId,
      username: 'John Doe',
      password: 'password123',
      profilePicUrl:
          'https://media.licdn.com/dms/image/v2/D4E03AQE6_00Lbd-Itw/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1697047665155?e=1750291200&v=beta&t=_BBvq5lAMPw3-cY4lHbN1M2_Y2aBYAsVfnJriLT1auA',
      email: 'j.doe@ufaz.az',
      streak: 5,
      points: 100,
      ghgIndex: 4.73,
      location: LatLng(413010, 49.945072),
      friendsIds: ['2', '3'],
    );
  }
}
