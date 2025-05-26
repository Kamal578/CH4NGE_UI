import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/post_form_entity.dart';
import 'package:either_dart/either.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getRecentPosts();
  Future<Either<String, String>> uploadPostForm(PostFormEntity post);
  Future<Either<String, PostEntity>> likePost(String postId, String userId);
  Future<Either<String, PostEntity>> sharePost(String postId, String userId);
} 