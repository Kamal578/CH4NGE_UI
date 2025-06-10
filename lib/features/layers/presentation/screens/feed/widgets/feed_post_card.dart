import 'package:ch4nge/core/auth/auth_manager.dart';
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
  final List<int> likedBy;
  final Future<void> Function(PostEntity post, String userId) onLike;
  final Future<void> Function(PostEntity post, String userId) onShare;
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
    required this.likedBy,
    required this.onLike,
    required this.onShare,
    required this.onTap,
  });

  @override
  FeedPostCardState createState() => FeedPostCardState();
}

class FeedPostCardState extends State<FeedPostCard>
    with TickerProviderStateMixin {
  final String userId = AuthManager.getId();
  bool _isLiking = false;
  bool _isSharing = false;
  late bool _isLiked;
  late int _currentLikeCount;
  late int _currentShareCount;
  late List<int> _currentLikedBy;

  // Animation controllers for smooth interactions
  late AnimationController _likeAnimationController;
  late AnimationController _shareAnimationController;
  late Animation<double> _likeScaleAnimation;
  late Animation<double> _shareScaleAnimation;
  late Animation<Color?> _likeColorAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize state
    _currentLikedBy = List.from(widget.likedBy);
    _isLiked = _currentLikedBy.contains(int.parse(userId));
    _currentLikeCount = widget.likeCount;
    _currentShareCount = widget.shareCount;

    // Initialize animations
    _setupAnimations();
  }

  void _setupAnimations() {
    // Like animation controller
    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Share animation controller
    _shareAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Scale animations for button press feedback
    _likeScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _likeAnimationController,
      curve: Curves.elasticOut,
    ));

    _shareScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _shareAnimationController,
      curve: Curves.easeInOut,
    ));

    // Color animation for like button
    _likeColorAnimation = ColorTween(
      begin: Colors.grey[700],
      end: Colors.red,
    ).animate(_likeAnimationController);
  }

  @override
  void didUpdateWidget(FeedPostCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only update if not currently performing an action to avoid conflicts
    if (!_isLiking && !_isSharing) {
      bool shouldUpdate = false;

      if (oldWidget.likeCount != widget.likeCount) {
        _currentLikeCount = widget.likeCount;
        shouldUpdate = true;
      }

      if (oldWidget.shareCount != widget.shareCount) {
        _currentShareCount = widget.shareCount;
        shouldUpdate = true;
      }

      if (oldWidget.likedBy != widget.likedBy) {
        _currentLikedBy = List.from(widget.likedBy);
        final newIsLiked = _currentLikedBy.contains(int.parse(userId));
        if (_isLiked != newIsLiked) {
          _isLiked = newIsLiked;
          // Animate to new state
          if (_isLiked) {
            _likeAnimationController.forward();
          } else {
            _likeAnimationController.reverse();
          }
          shouldUpdate = true;
        }
      }

      if (shouldUpdate && mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _handleLike() async {
    if (_isLiking) return;

    final int currentUserId = int.parse(userId);
    final bool wasLiked = _isLiked;
    final int originalLikeCount = _currentLikeCount;
    final List<int> originalLikedBy = List.from(_currentLikedBy);

    // Start animation immediately for instant feedback
    if (_isLiked) {
      _likeAnimationController.reverse();
    } else {
      _likeAnimationController.forward();
    }

    // Optimistic UI update with smooth state change
    setState(() {
      _isLiking = true;
      _isLiked = !_isLiked;

      if (_isLiked) {
        _currentLikeCount++;
        if (!_currentLikedBy.contains(currentUserId)) {
          _currentLikedBy.add(currentUserId);
        }
      } else {
        _currentLikeCount =
            (_currentLikeCount - 1).clamp(0, double.infinity).toInt();
        _currentLikedBy.remove(currentUserId);
      }
    });

    try {
      await widget.onLike(widget.post, userId);

      // Add a small delay to show the animation
      await Future.delayed(const Duration(milliseconds: 100));
    } catch (e) {
      // Revert optimistic update on error with smooth animation
      if (mounted) {
        setState(() {
          _isLiked = wasLiked;
          _currentLikeCount = originalLikeCount;
          _currentLikedBy = originalLikedBy;
        });

        // Revert animation
        if (wasLiked) {
          _likeAnimationController.forward();
        } else {
          _likeAnimationController.reverse();
        }

        // Show error feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to update like. Please try again.'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLiking = false;
        });
      }
    }
  }

  Future<void> _handleShare() async {
    if (_isSharing) return;

    final int originalShareCount = _currentShareCount;

    // Start share animation
    _shareAnimationController.forward().then((_) {
      _shareAnimationController.reverse();
    });

    // Optimistic UI update
    setState(() {
      _isSharing = true;
      _currentShareCount++;
    });

    try {
      await widget.onShare(widget.post, userId);

      // Add a small delay for better UX
      await Future.delayed(const Duration(milliseconds: 150));
    } catch (e) {
      // Revert optimistic update on error
      if (mounted) {
        setState(() {
          _currentShareCount = originalShareCount;
        });

        // Show error feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to share post. Please try again.'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    _shareAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
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
                      backgroundImage: widget.profilePicUrl.isEmpty ||
                              widget.profilePicUrl == 'http://localhost:8080'
                          ? const AssetImage("assets/images/user_profile.png")
                          : NetworkImage(widget.profilePicUrl) as ImageProvider,
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

              /// Post image
              const SizedBox(height: 8),
              ClipRRect(
                child: Image.network(
                  widget.postImageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    final localImageUrl =
                        'http://localhost:8000/${widget.postImageUrl}';
                    return Image.network(
                      localImageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),

              /// Like/Share row with smooth animations
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    // Animated like button
                    AnimatedBuilder(
                      animation: Listenable.merge([
                        _likeScaleAnimation,
                        _likeColorAnimation,
                      ]),
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _likeScaleAnimation.value,
                          child: IconButton(
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: _isLiking
                                  ? SizedBox(
                                      key: const ValueKey('loading'),
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          _likeColorAnimation.value ??
                                              Colors.red,
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      key: ValueKey(
                                          _isLiked ? 'liked' : 'not_liked'),
                                      _isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: _isLiked
                                          ? Colors.red
                                          : Colors.grey[700],
                                      size: 28,
                                    ),
                            ),
                            onPressed: _isLiking ? null : _handleLike,
                          ),
                        );
                      },
                    ),

                    // Animated like count
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        '$_currentLikeCount',
                        key: ValueKey(_currentLikeCount),
                        style: TextStyle(
                          color: _isLiked ? Colors.red : Colors.grey[700],
                          fontWeight:
                              _isLiked ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Animated share button
                    AnimatedBuilder(
                      animation: _shareScaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _shareScaleAnimation.value,
                          child: IconButton(
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: _isSharing
                                  ? SizedBox(
                                      key: const ValueKey('sharing'),
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.blue,
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      key: const ValueKey('share'),
                                      Icons.share,
                                      color: Colors.grey[700],
                                      size: 28,
                                    ),
                            ),
                            onPressed: _isSharing ? null : _handleShare,
                          ),
                        );
                      },
                    ),

                    // Animated share count
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        '$_currentShareCount',
                        key: ValueKey(_currentShareCount),
                      ),
                    ),
                  ],
                ),
              ),

              /// Author Comment
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
