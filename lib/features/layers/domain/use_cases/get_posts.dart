import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/post_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';

class GetPostsUseCase {
  final PostRepository postRepository;
  final UserRepository userRepository;

  GetPostsUseCase(
    this.postRepository,
    this.userRepository,
  );

  Future<List<PostEntity>> call() async {
    final posts = await postRepository.getRecentPosts();

    for (var post in posts) {
      final user = await userRepository.getUser(post.userId.toString());
      if (user.isLeft) {
        continue;
      } else {
        post.profileImageUrl = user.right.profilePicUrl;
        post.username = user.right.username;
      }
    }

    return posts;
  }
}
