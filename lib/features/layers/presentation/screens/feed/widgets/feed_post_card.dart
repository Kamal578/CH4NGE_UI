import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedPostCard extends StatefulWidget {
  final PostEntity post;
  final String profilePicUrl;
  final String username;
  final String postImageUrl;
  final int likeCount;
  final int shareCount;
  final String authorComment;
  final VoidCallback onShare;
  final VoidCallback onTap;

  const FeedPostCard({
    super.key,
    required this.post,
    required this.profilePicUrl,
    required this.username,
    required this.postImageUrl,
    required this.likeCount,
    required this.shareCount,
    required this.authorComment,
    required this.onShare,
    required this.onTap,
  });

  @override
  FeedPostCardState createState() => FeedPostCardState();
}

class FeedPostCardState extends State<FeedPostCard> {
  late bool _isLiked;
  late int _currentLikeCount;

  @override
  void initState() {
    super.initState();
    _isLiked = false;
    _currentLikeCount = widget.likeCount;
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        _currentLikeCount--;
      } else {
        _isLiked = true;
        _currentLikeCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3, // Creates the floating effect
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header: profile pic + username
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(widget.profilePicUrl),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              /// Post image with adaptive fitting
              const SizedBox(height: 8),
              ClipRRect(
                child: Image.network(
                  widget.postImageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// Like/Share row with stateful like button
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked ? Colors.red : null,
                      ),
                      onPressed: _toggleLike,
                    ),
                    Text('$_currentLikeCount'),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: widget.onShare,
                    ),
                    Text('${widget.shareCount}'),
                  ],
                ),
              ),

              /// Author Comment row
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: widget.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: widget.authorComment,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
