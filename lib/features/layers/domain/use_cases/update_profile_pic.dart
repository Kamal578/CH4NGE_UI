import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';
import 'package:either_dart/either.dart';

class UpdateProfilePicUseCase {
  final UserRepository userRepository;

  UpdateProfilePicUseCase(this.userRepository);

  Future<Either<String, String>> call(String userId, String imagePath) async {
    try {
      final newProfilePicUrl =
          await userRepository.updateProfilePic(userId, imagePath);
      return Right(newProfilePicUrl.right);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
