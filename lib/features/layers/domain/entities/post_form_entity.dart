import 'dart:io';

class PostFormEntity {
  String userId;
  final String title;
  final File image;

  PostFormEntity({
    required this.userId,
    required this.title,
    required this.image,
  });
}
