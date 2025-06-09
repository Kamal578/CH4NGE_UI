import 'dart:io';

import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/data/datasources/post_datasource.dart';
import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/post_form_entity.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_posts.dart';
import 'package:ch4nge/features/layers/domain/use_cases/like_post.dart';
import 'package:ch4nge/features/layers/domain/use_cases/share_post.dart';
import 'package:ch4nge/features/layers/domain/use_cases/upload_post_form.dart';
import 'package:ch4nge/features/layers/presentation/screens/feed/widgets/deep_link_handler.dart';
import 'package:ch4nge/features/layers/presentation/screens/feed/widgets/feed_post_card.dart';
import 'package:ch4nge/features/layers/presentation/screens/feed/widgets/upload_post_button.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:app_links/app_links.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({
    super.key,
    required this.getPostsUseCase,
    required this.uploadPostFormUseCase,
    required this.likePostUseCase,
    required this.sharePostUseCase,
  });

  final GetPostsUseCase getPostsUseCase;
  final UploadPostFormUseCase uploadPostFormUseCase;
  final LikePostUseCase likePostUseCase;
  final SharePostUseCase sharePostUseCase;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final String userId = AuthManager.getId();
  List<PostEntity> postCardData = []; // Initialize as empty list
  bool isLoading = true;
  bool isUploadingPost = false; // Track upload state
  late AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _loadData();
    _initDeepLinks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Initialize deep link handling
  void _initDeepLinks() {
    _appLinks = AppLinks();

    // Handle links when the app is already running
    _appLinks.uriLinkStream.listen((uri) {
      if (mounted) {
        DeepLinkHandler.handleDeepLink(context, uri.toString(), postCardData);
      }
    });

    // Handle links when the app is launched from a link
    _appLinks.getInitialLink().then((uri) {
      if (uri != null && mounted) {
        DeepLinkHandler.handleDeepLink(context, uri.toString(), postCardData);
      }
    });
  }

  Future<void> _loadData() async {
    try {
      setState(() => isLoading = true);

      // Clear cache to ensure fresh data
      final postDatasource = PostRemoteDatasource();
      await postDatasource.clearCache();

      final fetchedPosts = await widget.getPostsUseCase();

      if (mounted) {
        setState(() {
          postCardData = fetchedPosts;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
        debugPrint('Error loading data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to load data. Please try again.')),
        );
      }
    }
  }

  /// Refresh feed data
  Future<void> _refreshFeed() async {
    await _loadData();
  }

  /// Generate deep link URL for a post
  String _generatePostDeepLink(PostEntity post) {
    // Assuming your app has a custom scheme like 'ch4nge://'
    // You can also use universal links with your domain
    return 'ch4nge://post/${post.postId}?username=${Uri.encodeComponent(post.username!)}&title=${Uri.encodeComponent(post.title)}';
  }

  Future<void> _sharePost(PostEntity post, String userId) async {
    try {
      final deepLink = _generatePostDeepLink(post);
      final shareText =
          'Check out this post by ${post.username}: "${post.title}"\n\n$deepLink';

      final newPostData = await widget.sharePostUseCase(
        post.postId.toString(),
        userId,
      );

      if (newPostData.isLeft) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(newPostData.left)),
          );
        }
        return;
      }

      await SharePlus.instance.share(
        ShareParams(
          text: shareText,
          subject: 'Post by ${post.username}',
        ),
      );
    } catch (e) {
      debugPrint('Error sharing post: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to share post. Please try again.')),
        );
      }
      rethrow; // Rethrow to trigger error handling in UI
    }
  }

  Future<void> _likePost(PostEntity post, String userId) async {
    try {
      final newPostData = await widget.likePostUseCase(
        post.postId.toString(),
        userId,
      );

      if (newPostData.isLeft) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(newPostData.left)),
          );
        }
        return;
      }
    } catch (e) {
      debugPrint('Error liking post: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to like post. Please try again.')),
        );
      }
      rethrow; // Rethrow to trigger error handling in UI
    }
  }

  /// Handle uploading a new post
  Future<void> _handleNewPost(String comment, File? imageData) async {
    try {
      setState(() => isUploadingPost = true);

      final result = await widget.uploadPostFormUseCase(
        PostFormEntity(
          userId: int.parse(userId),
          title: comment,
          image: imageData ?? File(''),
        ),
      );

      // Check if upload was successful (adjust based on your use case return type)
      if (result.isRight) {
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Post uploaded successfully!'),
              backgroundColor: Color(0xFF7DD334),
            ),
          );
        }

        // Refresh the feed to show the new post
        await _refreshFeed();
      } else {
        // Handle upload error
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to upload post: ${result.left}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error uploading post: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to upload post. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isUploadingPost = false);
      }
    }
  }

  /// Handle opening a post (for deep link navigation)
  void _openPost(PostEntity post) {
    // Navigate to post detail page or handle deep link action
    // This could be used when handling incoming deep links
    Navigator.pushNamed(
      context,
      '/post_detail',
      arguments: {
        'postId': post.postId,
        'post': post,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppbarWidget(),
        bottomNavigationBar: _buildCustomNavbarWidget(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              _buildTitleWidget(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF7DD334),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildCustomAppbarWidget(),
      bottomNavigationBar: _buildCustomNavbarWidget(),
      floatingActionButton: _buildNewPostWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshFeed,
          color: const Color(0xFF7DD334),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                _buildTitleWidget(),
                SizedBox(height: 8.h),
                if (isUploadingPost)
                  Container(
                    padding: EdgeInsets.all(16.w),
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7DD334).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFF7DD334).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: const CircularProgressIndicator(
                            color: Color(0xFF7DD334),
                            strokeWidth: 2,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Uploading your post...',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF7DD334),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (postCardData.isEmpty && !isUploadingPost)
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                        Icon(
                          Icons.post_add,
                          size: 64.sp,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "No posts available",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Be the first to share something!",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...postCardData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final post = entry.value;

                    return Column(
                      children: [
                        _buildFeedPostCard(
                          post: post,
                          profilePicUrl: post.profileImageUrl!,
                          username: post.username!,
                          postImageUrl: post.imageUrl,
                          likedBy: post.likedBy,
                          likeCount: post.likedBy.length,
                          shareCount: post.sharedBy.length,
                          authorComment: post.title,
                        ),
                        if (index < postCardData.length - 1)
                          SizedBox(height: 16.h),
                      ],
                    );
                  }),
                SizedBox(
                    height: 80.h), // Extra space for floating action button
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Container(
      width: double.maxFinite,
      height: 32.h,
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Text(
        "My Feed",
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildFeedPostCard({
    required PostEntity post,
    required String profilePicUrl,
    required String username,
    required String postImageUrl,
    required List<int> likedBy,
    required int likeCount,
    required int shareCount,
    required String authorComment,
  }) {
    return FeedPostCard(
      post: post,
      profilePicUrl: profilePicUrl,
      username: username,
      postImageUrl: postImageUrl,
      likedBy: likedBy,
      likeCount: likeCount,
      shareCount: shareCount,
      authorComment: authorComment,
      onShare: _sharePost, // Pass the function reference, not call it
      onLike: _likePost, // Pass the function reference, not call it
      onTap: () => _openPost(post),
    );
  }

  Widget _buildNewPostWidget() {
    return UploadPostButton(
      onUpload: _handleNewPost,
    );
  }

  Widget _buildCustomNavbarWidget() {
    return const CustomBottomNavBar(
      selectedIndex: 0,
    );
  }

  PreferredSizeWidget _buildCustomAppbarWidget() {
    return const CustomAppBar(
      backgroundColor: Colors.white,
    );
  }
}
