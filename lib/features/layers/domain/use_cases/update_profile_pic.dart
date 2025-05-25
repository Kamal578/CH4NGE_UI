import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';

class UpdateProfilePicUseCase {
  final UserRepository repository;

  UpdateProfilePicUseCase(this.repository);

  Future<void> call(String userId, String imagePath) async {
    await repository.updateProfilePic(userId, imagePath);
  }
}