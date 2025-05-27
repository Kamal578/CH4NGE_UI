// Deep Link Handler Class
import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';

class DeepLinkHandler {
  static const String scheme = 'ch4nge';
  
  /// Parse deep link and extract post information
  static Map<String, String>? parsePostDeepLink(String deepLink) {
    try {
      final uri = Uri.parse(deepLink);
      
      if (uri.scheme != scheme || !uri.path.startsWith('/post/')) {
        return null;
      }
      
      final postId = uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
      if (postId == null) return null;
      
      return {
        'postId': postId,
        'username': uri.queryParameters['username'] ?? '',
        'title': uri.queryParameters['title'] ?? '',
      };
    } catch (e) {
      debugPrint('Error parsing deep link: $e');
      return null;
    }
  }
  
  /// Handle incoming deep link
  static void handleDeepLink(BuildContext context, String deepLink, List<PostEntity> posts) {
    final postData = parsePostDeepLink(deepLink);
    
    if (postData != null) {
      final postId = postData['postId'];
      
      // Try to find the post in the current posts list
      final post = posts.firstWhere(
        (p) => p.postId == postId,
        orElse: () => PostEntity(
          postId: postId!,
          userId: postData["userId"] ?? '',
          username: postData['username'],
          title: postData['title'] ?? '',
          imageUrl: '',
          profileImageUrl: '',
          likeNumber: 0,
          sharesNumber: 0,
        ),
      );
      
      // Show post detail dialog or navigate to post detail page
      _showPostDetail(context, post);
    } else {
      // Handle invalid deep link
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid post link')),
      );
    }
  }
  
  /// Show post detail in a dialog
  static void _showPostDetail(BuildContext context, PostEntity post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: post.profileImageUrl != null && post.profileImageUrl!.isNotEmpty
                          ? NetworkImage(post.profileImageUrl!)
                          : null,
                      child: post.profileImageUrl == null || post.profileImageUrl!.isEmpty
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.username ?? 'Unknown User',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Opened via deep link',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (post.imageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      post.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported),
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 12),
                Text(
                  post.title,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 20),
                    const SizedBox(width: 4),
                    Text('${post.likeNumber}'),
                    const SizedBox(width: 16),
                    Icon(Icons.share, color: Colors.blue, size: 20),
                    const SizedBox(width: 4),
                    Text('${post.sharesNumber}'),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Optionally navigate to full post detail page
                      // Navigator.pushNamed(context, '/post_detail', arguments: post);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7DD334),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View Full Post',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}