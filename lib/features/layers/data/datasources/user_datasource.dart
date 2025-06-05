import 'dart:convert';
import 'dart:io';
import 'package:ch4nge/core/api/api_service.dart';
import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/data/models/user/user_model.dart';
import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IUserDatasource {
  Future<UserEntity> getUser(String userId);
  Future<List<UserEntity>> getAllUsers();
  Future<List<UserEntity>> getFriends(String userId);
  Future<void> updateFriends(String userId, List<String> friendIds);
  Future<String> updateProfilePic(String userId, String imagePath);
  Future<void> clearCache();
}

class UserRemoteDatasource implements IUserDatasource {
  final ApiService _apiService = ApiService.instance;
  static const String _cacheKeyPrefix = 'user_cache_';
  static const String _allUsersKey = 'all_users_cache';
  static const String _friendsKey = 'friends_cache_';
  static const Duration _cacheValidityDuration = Duration(minutes: 5);

  @override
  Future<UserEntity> getUser(String userId) async {
    final cacheKey = '$_cacheKeyPrefix$userId';

    // Try to get from cache first
    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null && cachedData.isNotEmpty) {
      return UserModel.fromJson(cachedData.first).toEntity();
    }

    try {
      final response = await _apiService.get(
        '/users/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> usersData = response.data as List<dynamic>;
        final users =
            usersData.map((json) => UserModel.fromJson(json)).toList();

        await _cacheData(cacheKey, usersData);

        return users.firstWhere((user) => user.userId.toString() == userId).toEntity();
      } else {
        throw Exception('Failed to fetch user: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails and we have no cache, rethrow
      final cachedData = await _getCachedData(cacheKey, ignoreExpiry: true);
      if (cachedData != null && cachedData.isNotEmpty) {
        return UserModel.fromJson(cachedData.first).toEntity();
      }
      rethrow;
    }
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    const cacheKey = _allUsersKey;

    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null) {
      return cachedData
          .map((json) => UserModel.fromJson(json).toEntity())
          .toList();
    }

    try {
      final response = await _apiService.get(
        '/users',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> usersData = response.data as List<dynamic>;
        final users =
            usersData.map((json) => UserModel.fromJson(json)).toList();

        await _cacheData(cacheKey, usersData);

        for (final userData in usersData) {
          final individualCacheKey = '$_cacheKeyPrefix${userData['userId']}';
          await _cacheData(individualCacheKey, [userData]);
        }

        final userEntities = users.map((user) => user.toEntity()).toList();

        return userEntities;
      } else {
        throw Exception('Failed to fetch all users: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails and we have no cache, rethrow
      final cachedData = await _getCachedData(cacheKey, ignoreExpiry: true);
      if (cachedData != null) {
        return cachedData
            .map((json) => UserModel.fromJson(json).toEntity())
            .toList();
      }
      rethrow;
    }
  }

  @override
  Future<List<UserEntity>> getFriends(String userId) async {
    final cacheKey = '$_friendsKey$userId';

    // Try to get from cache first
    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null) {
      return cachedData
          .map((json) => UserModel.fromJson(json).toEntity())
          .toList();
    }

    try {
      // Fetch from API
      final response = await _apiService.get(
        '/users/$userId/friends',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> friendsData = response.data as List<dynamic>;
        final friends =
            friendsData.map((json) => UserModel.fromJson(json)).toList();

        // Cache the data
        await _cacheData(cacheKey, friendsData);

        // Also cache individual friends
        for (final friendData in friendsData) {
          final individualCacheKey = '$_cacheKeyPrefix${friendData['userId']}';
          await _cacheData(individualCacheKey, [friendData]);
        }

        final friendEntities =
            friends.map((friend) => friend.toEntity()).toList();

        return friendEntities;
      } else {
        throw Exception('Failed to fetch friends: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails and we have no cache, rethrow
      final cachedData = await _getCachedData(cacheKey, ignoreExpiry: true);
      if (cachedData != null) {
        return cachedData
            .map((json) => UserModel.fromJson(json).toEntity())
            .toList();
      }
      rethrow;
    }
  }

  @override
  Future<void> updateFriends(String userId, List<String> friendIds) async {
    try {
      final response = await _apiService.put(
        '/users/$userId/friends',
        data: {'friendIds': friendIds},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to update friends: ${response.statusCode}');
      }

      await _clearUserRelatedCaches(userId);
    } catch (e) {
      if (e is DioException) {
        throw Exception('Network error updating friends: ${e.message}');
      }
      rethrow;
    }
  }

  @override
  Future<String> updateProfilePic(String userId, String imagePath) async {
    try {
      // Create multipart form data
      final file = File(imagePath);
      final fileName = file.path.split('/').last;

      final formData = FormData.fromMap({
        'profilePic': await MultipartFile.fromFile(
          imagePath,
          filename: fileName,
        ),
      });

      final response = await _apiService.post(
        '/users/$userId/profile-pic',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
            'Content-Type': 'multipart/form-data',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data as Map<String, dynamic>;
        final newProfilePicUrl = responseData['profilePicUrl'] as String;

        // Clear related caches to force refresh
        await _clearUserRelatedCaches(userId);

        return newProfilePicUrl;
      } else {
        throw Exception(
            'Failed to update profile picture: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Network error updating profile picture: ${e.message}');
      }
      rethrow;
    }
  }

  @override
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    // Remove all user-related cache keys
    for (final key in keys) {
      if (key.startsWith(_cacheKeyPrefix) ||
          key == _allUsersKey ||
          key.startsWith(_friendsKey)) {
        await prefs.remove(key);
      }
    }
  }

  Future<List<dynamic>?> _getCachedData(String key,
      {bool ignoreExpiry = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedString = prefs.getString(key);

      if (cachedString == null) return null;

      final cachedMap = jsonDecode(cachedString) as Map<String, dynamic>;
      final timestamp =
          DateTime.fromMillisecondsSinceEpoch(cachedMap['timestamp']);
      final data = cachedMap['data'] as List<dynamic>;

      // Check if cache is still valid
      if (!ignoreExpiry &&
          DateTime.now().difference(timestamp) > _cacheValidityDuration) {
        await prefs.remove(key);
        return null;
      }

      return data;
    } catch (e) {
      // If there's any error reading cache, return null
      return null;
    }
  }

  Future<void> _cacheData(String key, List<dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheMap = {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'data': data,
      };

      await prefs.setString(key, jsonEncode(cacheMap));
    } catch (e) {
      // If caching fails, continue without caching
      // This ensures the app doesn't break due to cache issues
    }
  }

  Future<void> _clearUserRelatedCaches(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    // Clear specific user cache
    await prefs.remove('$_cacheKeyPrefix$userId');

    // Clear friends cache for this user
    await prefs.remove('$_friendsKey$userId');

    // Clear all users cache since it might contain outdated data
    await prefs.remove(_allUsersKey);

    // Clear friends caches that might contain this user
    for (final key in keys) {
      if (key.startsWith(_friendsKey)) {
        await prefs.remove(key);
      }
    }
  }
}
