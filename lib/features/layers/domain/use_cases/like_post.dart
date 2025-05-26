
import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/post_repository.dart';
import 'package:either_dart/either.dart';

class LikePostUseCase {
  final PostRepository repository;

  LikePostUseCase(this.repository);

  Future<Either<String, PostEntity>> call(String postId, String userId) async {
    return await repository.likePost(postId, userId);
  }
}