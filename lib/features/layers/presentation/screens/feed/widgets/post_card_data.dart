class PostCardData {
  String profilePicUrl;
  String username;
  String postImageUrl;
  List<int> likedBy;
  int likeCount;
  int shareCount;
  String authorComment;

  PostCardData({
    required this.profilePicUrl,
    required this.username,
    required this.postImageUrl,
    required this.likedBy,
    required this.likeCount,
    required this.shareCount,
    required this.authorComment,
  });
}