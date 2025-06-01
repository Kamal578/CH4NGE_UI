import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_posts.dart';
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
  });

  final GetPostsUseCase getPostsUseCase;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late List<PostEntity> postCardData;
  bool isLoading = true;
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
      final postCardData = await widget.getPostsUseCase();

      setState(() {
        this.postCardData = postCardData;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error loading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data. Please try again.')),
      );
    }
  }

  /// Generate deep link URL for a post
  String _generatePostDeepLink(PostEntity post) {
    // Assuming your app has a custom scheme like 'ch4nge://'
    // You can also use universal links with your domain
    return 'ch4nge://post/${post.postId}?username=${Uri.encodeComponent(post.username!)}&title=${Uri.encodeComponent(post.title)}';
  }

  /// Handle sharing a post with deep link
  Future<void> _sharePost(PostEntity post) async {
    try {
      final deepLink = _generatePostDeepLink(post);
      final shareText =
          'Check out this post by ${post.username}: "${post.title}"\n\n$deepLink';

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
              Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF7DD334),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppbarWidget(),
        bottomNavigationBar: _buildCustomNavbarWidget(),
        floatingActionButton: _buildNewPostWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              _buildTitleWidget(),
              SizedBox(height: 8.h),
              _buildFeedPostCard(
                post: postCardData[0],
                profilePicUrl: postCardData[0].profileImageUrl!,
                username: postCardData[0].username!,
                postImageUrl: postCardData[0].imageUrl,
                likeCount: postCardData[0].likeNumber,
                shareCount: postCardData[0].sharesNumber,
                authorComment: postCardData[0].title,
              ),
              SizedBox(height: 16.h),
              ...List.generate(
                postCardData.length - 1,
                (index) => Column(
                  children: [
                    _buildFeedPostCard(
                      post: postCardData[index + 1],
                      profilePicUrl: postCardData[index + 1].profileImageUrl!,
                      username: postCardData[index + 1].username!,
                      postImageUrl: postCardData[index + 1].imageUrl,
                      likeCount: postCardData[index + 1].likeNumber,
                      shareCount: postCardData[index + 1].sharesNumber,
                      authorComment: postCardData[index + 1].title,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTitleWidget() {
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

  _buildFeedPostCard({
    required PostEntity post,
    required String profilePicUrl,
    required String username,
    required String postImageUrl,
    required int likeCount,
    required int shareCount,
    required String authorComment,
  }) {
    return FeedPostCard(
      post: post,
      profilePicUrl: profilePicUrl,
      username: username,
      postImageUrl: postImageUrl,
      likeCount: likeCount,
      shareCount: shareCount,
      authorComment: authorComment,
      onShare: () => _sharePost(post),
      onTap: () => _openPost(post),
    );
  }

  _buildNewPostWidget() {
    return UploadPostButton(
      onUpload: (comment, imageData) {
        // Handle the upload logic, e.g., send data to your provider or backend.
        print("Comment: $comment, Image: $imageData");
      },
    );
  }

  _buildCustomNavbarWidget() {
    return CustomBottomNavBar(
      selectedIndex: 0,
    );
  }

  _buildCustomAppbarWidget() {
    return CustomAppBar(
      backgroundColor: Colors.white,
    );
  }
}
