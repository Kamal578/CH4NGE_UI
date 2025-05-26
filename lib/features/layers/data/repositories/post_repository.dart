import 'package:ch4nge/features/layers/data/datasources/post_datasource.dart';
import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/post_form_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/post_repository.dart';
import 'package:either_dart/either.dart';

class PostRepositoryImpl implements PostRepository {
  final IPostDatasource datasource;

  PostRepositoryImpl({required this.datasource});

  // TODO: Remove this mock data when API is ready
  List<PostEntity> postCardData = [
    PostEntity(
      postId: "1",
      userId: "12346",
      imageUrl:
          "https://www.vintagetreecare.com/wp-content/uploads/2023/06/planting-tree.jpg",
      likeNumber: 100,
      sharesNumber: 50,
      title: "This is a sample comment.",
    ),
    PostEntity(
      postId: "2",
      userId: "12347",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW-ux6VpEBhUHhFTFjB_CcZ-BY3vE6PliafQ&s",
      likeNumber: 200,
      sharesNumber: 80,
      title:
          "Long long long long long long long long long long sample comment.",
    ),
  ];

  // TODO: Uncomment when API is ready
  // @override
  // Future<List<PostEntity>> getRecentPosts() async {
  //   try {
  //     return await datasource.getRecentPosts();
  //   } catch (e) {
  //     // Return empty list as fallback instead of throwing
  //     // This allows the app to continue functioning even if posts can't be loaded
  //     return [];
  //   }
  // }

  // TODO: Remove when API is ready
  @override
  Future<List<PostEntity>> getRecentPosts() async {
    await Future.delayed(Duration(seconds: 1));

    return postCardData;
  }


  @override
  Future<Either<String, String>> uploadPostForm(PostFormEntity post) async {
    try {
      // Validate post form before uploading
      final validationError = _validatePostForm(post);
      if (validationError != null) {
        return Left(validationError);
      }

      await datasource.uploadPostForm(post);
      return const Right("Post uploaded successfully");
    } catch (e) {
      return Left("Failed to upload post: ${e.toString()}");
    }
  }

    @override
  Future<Either<String, PostEntity>> likePost(String postId, String userId) async {
    try {
      // Validate inputs
      if (postId.trim().isEmpty) {
        return const Left("Post ID cannot be empty");
      }
      
      if (userId.trim().isEmpty) {
        return const Left("User ID cannot be empty");
      }

      final updatedPost = await datasource.likePost(postId, userId);
      return Right(updatedPost);
    } catch (e) {
      return Left("Failed to like post: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, PostEntity>> sharePost(String postId, String userId) async {
    try {
      // Validate inputs
      if (postId.trim().isEmpty) {
        return const Left("Post ID cannot be empty");
      }
      
      if (userId.trim().isEmpty) {
        return const Left("User ID cannot be empty");
      }

      final updatedPost = await datasource.sharePost(postId, userId);
      return Right(updatedPost);
    } catch (e) {
      return Left("Failed to share post: ${e.toString()}");
    }
  }

  String? _validatePostForm(PostFormEntity post) {
    if (post.userId.isEmpty) {
      return "User ID is required";
    }
    
    if (post.title.trim().isEmpty) {
      return "Post title cannot be empty";
    }
    
    if (post.title.length > 500) {
      return "Post title is too long (max 500 characters)";
    }
    
    if (post.image.path.isEmpty && post.image.path.split('/').last.isEmpty) {
      return "Image is required for the post";
    }
    
    return null;
  }
}