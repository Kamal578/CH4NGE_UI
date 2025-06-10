import 'dart:convert';
import 'dart:io';
import 'package:ch4nge/core/api/api_service.dart';
import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/core/di/service_locator.dart';
import 'package:ch4nge/core/shared/config.dart';
import 'package:ch4nge/features/layers/data/models/post/post_model.dart';
import 'package:ch4nge/features/layers/data/models/post_form/post_form_model.dart';
import 'package:ch4nge/features/layers/domain/entities/post_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/post_form_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IPostDatasource {
  Future<void> uploadPostForm(PostFormEntity post);
  Future<List<PostEntity>> getRecentPosts();
  Future<PostEntity> likePost(String postId, String userId);
  Future<PostEntity> sharePost(String postId, String userId);
}

class PostRemoteDatasource implements IPostDatasource {
  final ApiService _apiService = ApiService.instance;
  static const String _cacheKey = 'recent_posts_cache';
  static const Duration _cacheValidityDuration = Duration(minutes: 10);

  @override
  Future<void> uploadPostForm(PostFormEntity postEntity) async {
    try {
      final postFormModel = PostFormModel(
        userId: postEntity.userId,
        title: postEntity.title,
        imageUrl: postEntity.image.path,
        imageName: postEntity.image.path.split('/').last,
      );

      // Create multipart form data if we have an image file
      FormData? formData;
      if (postFormModel.imageUrl.isNotEmpty &&
          !postFormModel.imageUrl.startsWith('http')) {
        // Assuming imageUrl is a file path when not starting with http
        final file = File(postFormModel.imageUrl);
        if (await file.exists()) {
          formData = FormData.fromMap({
            'userId': postFormModel.userId,
            'title': postFormModel.title,
            'imageName': postFormModel.imageName,
            'image': await MultipartFile.fromFile(
              postFormModel.imageUrl,
              filename: postFormModel.imageName,
            ),
          });
        }
      }

      final response = await _apiService.post(
        '/posts',
        data: formData ?? postFormModel.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
            'Content-Type':
                formData != null ? 'multipart/form-data' : 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to upload post: ${response.statusCode}');
      }

      // Clear cache after successful upload
      await clearCache();
    } catch (e) {
      if (e is DioException) {
        throw Exception('Network error uploading post: ${e.message}');
      }
      rethrow;
    }
  }

  @override
  Future<List<PostEntity>> getRecentPosts() async {
    final Config config = serviceLocator<Config>();
    final cachedData = await _getCachedData();
    if (cachedData != null) {
      return cachedData
          .map((json) => PostModel.fromJson(json).toEntity())
          .toList();
    }

    try {
      final response = await _apiService.get(
        '/posts/recent',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> postsData = response.data as List<dynamic>;
        for (final post in postsData) {
          if (post is Map<String, dynamic>) {
            post['imageUrl'] = '${config.apiBaseUrl}${post['imageUrl']}';
            debugPrint(
                'DATASOURCE Post image DATA URL: ${post['imageUrl']}'); // Debugging line
          }
        }

        

        final posts =
            postsData.map((json) => PostModel.fromJson(json)).toList();

        // Cache the data
        await _cacheData(postsData);

        debugPrint('DATASOURCE Post image MODELS URL: ${posts[0].imageUrl}'); // Debugging line

        return posts.map((post) => post.toEntity()).toList();
      } else {
        throw Exception('Failed to fetch recent posts: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails and we have no cache, rethrow
      final cachedData = await _getCachedData(ignoreExpiry: true);
      if (cachedData != null) {
        return cachedData
            .map((json) => PostModel.fromJson(json).toEntity())
            .toList();
      }
      rethrow;
    }
  }

  @override
  Future<PostEntity> likePost(String postId, String userId) async {
    try {
      final response = await _apiService.post(
        '/posts/$postId/like',
        data: {'userId': userId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final postData = response.data["post"] as Map<String, dynamic>;
        final updatedPost = PostModel.fromJson(postData);

        // Update cache with the new post data
        await _updatePostInCache(updatedPost);

        return updatedPost.toEntity();
      } else {
        throw Exception('Failed to like post: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Network error liking post: ${e.message}');
      }
      rethrow;
    }
  }

  @override
  Future<PostEntity> sharePost(String postId, String userId) async {
    try {
      final response = await _apiService.post(
        '/posts/$postId/share',
        data: {'userId': userId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final postData = response.data as Map<String, dynamic>;
        final updatedPost = PostModel.fromJson(postData);

        // Update cache with the new post data
        await _updatePostInCache(updatedPost);

        return updatedPost.toEntity();
      } else {
        throw Exception('Failed to share post: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Network error sharing post: ${e.message}');
      }
      rethrow;
    }
  }

  Future<List<dynamic>?> _getCachedData({bool ignoreExpiry = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedString = prefs.getString(_cacheKey);

      if (cachedString == null) return null;

      final cachedMap = jsonDecode(cachedString) as Map<String, dynamic>;
      final timestamp =
          DateTime.fromMillisecondsSinceEpoch(cachedMap['timestamp']);
      final data = cachedMap['data'] as List<dynamic>;

      // Check if cache is still valid
      if (!ignoreExpiry &&
          DateTime.now().difference(timestamp) > _cacheValidityDuration) {
        await prefs.remove(_cacheKey);
        return null;
      }

      return data;
    } catch (e) {
      return null;
    }
  }

  Future<void> _cacheData(List<dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheMap = {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'data': data,
      };

      await prefs.setString(_cacheKey, jsonEncode(cacheMap));
    } catch (e) {
      throw Exception('Failed to cache data: ${e.toString()}');
    }
  }

  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
    } catch (e) {
      throw Exception('Failed to clear cache: ${e.toString()}');
    }
  }

  Future<void> _updatePostInCache(PostModel updatedPost) async {
    try {
      final cachedData = await _getCachedData(ignoreExpiry: true);
      if (cachedData == null) return;

      // Find the index of the post to update
      final index =
          cachedData.indexWhere((json) => json['id'] == updatedPost.postId);
      if (index != -1) {
        cachedData[index] = updatedPost.toJson();
        await _cacheData(cachedData);
      }
    } catch (e) {
      throw Exception('Failed to update post in cache: ${e.toString()}');
    }
  }
}
