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
  List<PostCardData> postCardData = [
    PostCardData(
      profilePicUrl:
          "https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE",
      username: "Kamush Skibidi",
      postImageUrl:
          "https://www.vintagetreecare.com/wp-content/uploads/2023/06/planting-tree.jpg",
      likeCount: 100,
      shareCount: 50,
      authorComment: "This is a sample comment.",
      fitWidth: true,
    ),
    PostCardData(
      profilePicUrl:
          "https://media.licdn.com/dms/image/v2/C4E03AQGrdlO8sT78ug/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1663355766652?e=1749081600&v=beta&t=wKnfP2SW9E27yg6owE7tjLAPKOx5GlAhzqMN5BOWC-w",
      username: "Freaky Pavel",
      postImageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRl0C0pHDJx6DmOlaUmH5Igsk72aM2n7dDRBA&s",
      likeCount: 200,
      shareCount: 80,
      authorComment:
          "Long long long long long long long long long long sample comment.",
      fitWidth: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppbarWidget(),
        bottomNavigationBar: _buildCustomNavbarWidget(),
        floatingActionButton: _buildNewPostWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _buildTitleWidget(),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  _buildFeedPostCard(
                    profilePicUrl: postCardData[0].profilePicUrl,
                    username: postCardData[0].username,
                    postImageUrl: postCardData[0].postImageUrl,
                    likeCount: postCardData[0].likeCount,
                    shareCount: postCardData[0].shareCount,
                    authorComment: postCardData[0].authorComment,
                    fitWidth: postCardData[0].fitWidth,
                  ),
                  SizedBox(height: 16.h),
                  _buildTopCommentWidget(),
                  SizedBox(height: 16.h),
                  ...List.generate(
                    postCardData.length - 1,
                    (index) => Column(
                      children: [
                        _buildFeedPostCard(
                          profilePicUrl: postCardData[index + 1].profilePicUrl,
                          username: postCardData[index + 1].username,
                          postImageUrl: postCardData[index + 1].postImageUrl,
                          likeCount: postCardData[index + 1].likeCount,
                          shareCount: postCardData[index + 1].shareCount,
                          authorComment: postCardData[index + 1].authorComment,
                          fitWidth: postCardData[index + 1].fitWidth,
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
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

  _buildFeedPostCard({
    required String profilePicUrl,
    required String username,
    required String postImageUrl,
    required int likeCount,
    required int shareCount,
    required String authorComment,
    required bool fitWidth,
  }) {
    return FeedPostCard(
      profilePicUrl: profilePicUrl,
      username: username,
      postImageUrl: postImageUrl,
      likeCount: likeCount,
      shareCount: shareCount,
      authorComment: authorComment,
      fitWidth: fitWidth,
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
      onUpload: (comment, fitWidth, imageData) {
        // Handle the upload logic, e.g., send data to your provider or backend.
        print("Comment: $comment, FitWidth: $fitWidth, Image: $imageData");
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

class FeedPostCard extends StatefulWidget {
  final String profilePicUrl;
  final String username;
  final String postImageUrl;
  final int likeCount;
  final int shareCount;
  final String authorComment;
  final bool fitWidth;
  final VoidCallback onShare;

  const FeedPostCard({
    super.key,
    required this.profilePicUrl,
    required this.username,
    required this.postImageUrl,
    required this.likeCount,
    required this.shareCount,
    required this.authorComment,
    required this.fitWidth,
    required this.onShare,
  });

  @override
  _FeedPostCardState createState() => _FeedPostCardState();
}

class _FeedPostCardState extends State<FeedPostCard> {
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
                ],
              ),
            ),

            /// Post image with adaptive fitting
            const SizedBox(height: 8),
            ClipRRect(
              child: widget.fitWidth
                  ? Container(
                      color: Colors.black,
                      child: Image.network(
                        widget.postImageUrl,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  : Image.network(
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
    );
  }
}

class TopCommentWidget extends StatelessWidget {
  final String title;
  final String commentText;
  final int likes;
  final int shares;

  const TopCommentWidget({
    super.key,
    required this.title,
    required this.commentText,
    required this.likes,
    required this.shares,
  });

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
            color: const Color(0xFF7DD334),
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
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              /// Likes / Shares row
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text('$likes', style: const TextStyle(color: Colors.white)),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.share,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text('$shares', style: const TextStyle(color: Colors.white)),
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
  final Function(String comment, bool fitWidth, dynamic imageData) onUpload;

  const UploadPostButton({
    super.key,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF7DD334),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.2 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add_rounded),
          color: Colors.white,
          onPressed: () {
            _showUploadSheet(context);
          },
        ),
      ),
    );
  }

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: UploadPostSheet(onUpload: onUpload),
        );
      },
    );
  }
}

class UploadPostSheet extends StatefulWidget {
  final Function(String comment, bool fitWidth, dynamic imageData) onUpload;
  const UploadPostSheet({Key? key, required this.onUpload}) : super(key: key);

  @override
  _UploadPostSheetState createState() => _UploadPostSheetState();
}

class _UploadPostSheetState extends State<UploadPostSheet> {
  final TextEditingController _commentController = TextEditingController();
  bool _fitWidth = false;
  dynamic _imageData; // Placeholder for image data

  @override
  Widget build(BuildContext context) {
    final sheetHeight = MediaQuery.of(context).size.height * 0.8;
    return Container(
      height: sheetHeight,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create New Post",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Post Comment",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_camera),
                label: const Text("Upload Photo"),
              ),
              Row(
                children: [
                  const Text("Fit Width"),
                  Switch(
                    value: _fitWidth,
                    onChanged: (value) {
                      setState(() {
                        _fitWidth = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                widget.onUpload(
                  _commentController.text,
                  _fitWidth,
                  _imageData,
                );
                Navigator.pop(context);
              },
              child: const Text("Post"),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  void _pickImage() async {
    // Placeholder for image picking.
    // Replace this with an image picker call (e.g., using the image_picker package).
    setState(() {
      _imageData = "dummy_image_data"; // Simulated image data
    });
  }
}

class PostCardData {
  String profilePicUrl;
  String username;
  String postImageUrl;
  int likeCount;
  int shareCount;
  String authorComment;
  bool fitWidth;

  PostCardData({
    required this.profilePicUrl,
    required this.username,
    required this.postImageUrl,
    required this.likeCount,
    required this.shareCount,
    required this.authorComment,
    required this.fitWidth,
  });
}
