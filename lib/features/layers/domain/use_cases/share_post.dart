import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/post_repository.dart';
import 'package:either_dart/either.dart';

class SharePostUseCase {
  final PostRepository repository;

  SharePostUseCase(this.repository);

  Future<Either<String, PostEntity>> call(String postId, String userId) async {
    return await repository.sharePost(postId, userId);
  }
}