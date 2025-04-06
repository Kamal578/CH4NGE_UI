import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppbarWidget(),
        bottomNavigationBar: _buildCustomNavbarWidget(),
        floatingActionButton: _buildNewPostWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _buildTitleWidget(),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 32.h),
                  _buildFeedPostCard(),
                  SizedBox(height: 16.h),
                  _buildTopCommentWidget(),
                  SizedBox(height: 16.h),
                  _buildFeedPostCard(),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTitleWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
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
      ),
    );
  }

  _buildFeedPostCard() {
    return FeedPostCard(
      profilePicUrl:
          "https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE",
      username: "Kamush Skibidi",
      postImageUrl:
          "https://www.vintagetreecare.com/wp-content/uploads/2023/06/planting-tree-1024x683.jpg",
      likeCount: 120,
      shareCount: 45,
      onLike: () {
        // Handle like action
      },
      onShare: () {
        // Handle share action
      },
    );
  }

  _buildTopCommentWidget() {
    return TopCommentWidget(
      title: "Your Top Comment",
      commentText:
          "This is a sample comment text that can be long and should be wrapped properly.",
      likes: 10,
      shares: 5,
    );
  }

  _buildNewPostWidget() {
    return UploadPostButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "Upload New Post",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Post Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.photo_camera),
                      label: const Text("Choose Image"),
                      onPressed: () {
                        // Handle picking an image
                      },
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Handle upload
                      },
                      child: const Text("Post"),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
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
      actions: [
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            "assets/icons/notifications_icon.png",
            width: 28.w,
            height: 28.h,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            "assets/icons/settings_icon.png",
            width: 28.w,
            height: 28.h,
          ),
        ),
      ],
    );
  }
}

class FeedPostCard extends StatelessWidget {
  final String profilePicUrl;
  final String username;
  final String postImageUrl;
  final int likeCount;
  final int shareCount;
  final VoidCallback onLike;
  final VoidCallback onShare;

  const FeedPostCard({
    Key? key,
    required this.profilePicUrl,
    required this.username,
    required this.postImageUrl,
    required this.likeCount,
    required this.shareCount,
    required this.onLike,
    required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3, // Creates the floating effect
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
                    backgroundImage: NetworkImage(profilePicUrl),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            /// Post image
            const SizedBox(height: 8),
            ClipRRect(
              child: Image.network(
                postImageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            /// Like/Share row
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: onLike,
                  ),
                  Text('$likeCount'),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: onShare,
                  ),
                  Text('$shareCount'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopCommentWidget extends StatelessWidget {
  final String title;
  final String commentText;
  final int likes;
  final int shares;

  const TopCommentWidget({
    Key? key,
    required this.title,
    required this.commentText,
    required this.likes,
    required this.shares,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        /// Comment container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 228, 249, 223),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Comment text
              Text(
                commentText,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              /// Likes / Shares row
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red.shade400,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text('$likes'),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.share,
                    color: Colors.blue.shade400,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text('$shares'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UploadPostButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UploadPostButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
