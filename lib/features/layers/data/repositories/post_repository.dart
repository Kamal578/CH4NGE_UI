import 'dart:typed_data';

import 'package:ch4nge/features/layers/data/models/post_form/post_form_model.dart';
import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/post_form_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/post_repository.dart';
import 'package:either_dart/either.dart';
import 'package:path/path.dart' as path;

class PostRepositoryImpl implements PostRepository {
  List<PostEntity> postCardData = [
    PostEntity(
      postId: "1",
      userId: "12346",
      commentIds: [],
      imageUrl:
          "https://www.vintagetreecare.com/wp-content/uploads/2023/06/planting-tree.jpg",
      likeNumber: 100,
      sharesNumber: 50,
      title: "This is a sample comment.",
    ),
    PostEntity(
      postId: "2",
      userId: "12347",
      commentIds: [],
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW-ux6VpEBhUHhFTFjB_CcZ-BY3vE6PliafQ&s",
      likeNumber: 200,
      sharesNumber: 80,
      title:
          "Long long long long long long long long long long sample comment.",
    ),
  ];

  @override
  Future<List<PostEntity>> getRecentPosts() async {
    await Future.delayed(Duration(seconds: 1));

    return postCardData;
  }

  @override
  Future<Either<String, Right>> uploadPostForm(PostFormEntity post) async {
    try {
      final Uint8List bytes = await post.image.readAsBytes();
      final String imageName = path.basename(post.image.path);

      final postData = PostFormModel(
        userId: post.userId,
        title: post.title,
        imageBytes: bytes,
        imageName: imageName,
      );

      return Right(Right("Post form uploaded successfully"));
    } catch (e) {
      return Left("Error converting post form entity to model");
    }
  }
}
