import 'package:ch4nge/features/layers/domain/entities/post_form_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/post_repository.dart';
import 'package:either_dart/either.dart';

class UploadPostFormUseCase {
  final PostRepository repository;

  UploadPostFormUseCase(this.repository);

  Future<Either<String, String>> call(PostFormEntity post) async {
    await repository.uploadPostForm(post);
    return Right("Post form uploaded successfully");
  }
}
