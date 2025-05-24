class PostEntity {
  PostEntity({
    required this.postId,
    required this.userId,
    required this.title,
    required this.imageUrl,
    required this.likeNumber,
    required this.sharesNumber,
    this.profileImageUrl,
    this.username,
  });

  final String postId;
  final String userId;
  final String title;
  final String imageUrl;
  final int likeNumber;
  final int sharesNumber;
  String? profileImageUrl;
  String? username;
}
