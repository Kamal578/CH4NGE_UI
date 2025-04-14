class CommentEntity {
  CommentEntity({
    required this.commentId,
    required this.userId,
    required this.postId,
    required this.content,
    required this.likeNumber,
    required this.sharesNumber,
  });

  final String commentId;
  final String userId;
  final String postId;
  final String content;
  final int likeNumber;
  final int sharesNumber;
}