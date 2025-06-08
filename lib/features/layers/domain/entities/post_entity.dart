class PostEntity {
  PostEntity({
    required this.postId,
    required this.userId,
    required this.title,
    required this.imageUrl,
    required this.likedBy,
    required this.sharedBy,
    required this.likeNumber,
    required this.sharesNumber,
    this.isLiked,
    this.profileImageUrl,
    this.username,
  });

  final int postId;
  final int userId;
  final String title;
  final String imageUrl;
  final List<int> likedBy;
  final List<int> sharedBy;
  final int likeNumber;
  final int sharesNumber;
  final bool? isLiked;
  String? profileImageUrl;
  String? username;

  PostEntity copyWith({
    int? postId,
    int? userId,
    String? title,
    String? username,
    String? profileImageUrl,
    String? imageUrl,
    List<int>? likedBy,
    List<int>? sharedBy,
    int? likeNumber,
    int? sharesNumber,
    bool? isLiked,
  }) {
    return PostEntity(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      likedBy: likedBy ?? this.likedBy,
      sharedBy: sharedBy ?? this.sharedBy,
      likeNumber: likeNumber ?? this.likeNumber,
      sharesNumber: sharesNumber ?? this.sharesNumber,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
