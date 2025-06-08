import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheTimestampMapper {
  // Cache key constants matching your datasource
  static const String _cacheKeyPrefix = 'user_cache_';
  static const String _allUsersKey = 'all_users_cache';
  static const String _friendsKey = 'friends_cache_';
  static const String _achievementsCachePrefix = 'achievements_cache_';
  static const String _nextAchievementKey = 'next_achievement_';
  static const String _progressKey = 'achievement_progress_';
  static const String _weeklyChallengePrefix = 'weekly_challenge_cache_';
  static const String _miniChallengePrefix = 'mini_challenges_cache_';
  static const String _friendsActivitiesPrefix = 'friends_activities_cache_';
  static const String _recentPostsKey = 'recent_posts_cache';

  /// Base function to retrieve timestamp from any cache key
  static Future<DateTime?> _getTimestampForKey(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedString = prefs.getString(key);

      if (cachedString == null) return null;

      final cachedMap = jsonDecode(cachedString) as Map<String, dynamic>;
      final timestamp =
          DateTime.fromMillisecondsSinceEpoch(cachedMap['timestamp']);

      return timestamp;
    } catch (e) {
      return null;
    }
  }

  /// Base function to set timestamp for any cache key
  static Future<bool> _setTimestampForKey(String key, DateTime timestamp) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Get existing cache data or create new structure
      Map<String, dynamic> cacheData = {};
      final existingCache = prefs.getString(key);
      if (existingCache != null) {
        cacheData = jsonDecode(existingCache) as Map<String, dynamic>;
      }
      
      // Update timestamp
      cacheData['timestamp'] = timestamp.millisecondsSinceEpoch;
      
      // Save back to SharedPreferences
      return await prefs.setString(key, jsonEncode(cacheData));
    } catch (e) {
      return false;
    }
  }

  // GET TIMESTAMP FUNCTIONS

  /// Get timestamp for individual user cache
  static Future<DateTime?> getUserCacheTimestamp(String userId) async {
    final key = '$_cacheKeyPrefix$userId';
    return await _getTimestampForKey(key);
  }

  /// Get timestamp for all users cache
  static Future<DateTime?> getAllUsersCacheTimestamp() async {
    return await _getTimestampForKey(_allUsersKey);
  }

  /// Get timestamp for friends cache
  static Future<DateTime?> getFriendsCacheTimestamp(String userId) async {
    final key = '$_friendsKey$userId';
    return await _getTimestampForKey(key);
  }

  static Future<DateTime?> getAllAchievementsCacheTimestamp(
      String userId) async {
    final key = '${_achievementsCachePrefix}all_$userId';
    return await _getTimestampForKey(key);
  }

  static Future<DateTime?> getNextAchievementCacheTimestamp(
      String userId) async {
    final key = '$_nextAchievementKey$userId';
    return await _getTimestampForKey(key);
  }

  static Future<DateTime?> getAchievementProgressCacheTimestamp(
      String userId) async {
    final key = '$_progressKey$userId';
    return await _getTimestampForKey(key);
  }

  static Future<DateTime?> getWeeklyChallengeCacheTimestamp(
      String userId) async {
    final key = '$_weeklyChallengePrefix$userId';
    return await _getTimestampForKey(key);
  }

  static Future<DateTime?> getMiniChallengesCacheTimestamp(
      String userId) async {
    final key = '$_miniChallengePrefix$userId';
    return await _getTimestampForKey(key);
  }

  static Future<DateTime?> getFriendsActivitiesCacheTimestamp(
      List<String> userIds) async {
    // Create cache key the same way as the datasource
    final sortedUserIds = List<String>.from(userIds)..sort();
    final key = '$_friendsActivitiesPrefix${sortedUserIds.join('_')}';
    return await _getTimestampForKey(key);
  }

  static Future<DateTime?> getRecentPostsCacheTimestamp() async {
    return await _getTimestampForKey(_recentPostsKey);
  }

  // SET TIMESTAMP FUNCTIONS

  /// Set timestamp for individual user cache
  static Future<bool> setUserCacheTimestamp(String userId, DateTime timestamp) async {
    final key = '$_cacheKeyPrefix$userId';
    return await _setTimestampForKey(key, timestamp);
  }

  /// Set timestamp for all users cache
  static Future<bool> setAllUsersCacheTimestamp(DateTime timestamp) async {
    return await _setTimestampForKey(_allUsersKey, timestamp);
  }

  /// Set timestamp for friends cache
  static Future<bool> setFriendsCacheTimestamp(String userId, DateTime timestamp) async {
    final key = '$_friendsKey$userId';
    return await _setTimestampForKey(key, timestamp);
  }

  /// Set timestamp for all achievements cache
  static Future<bool> setAllAchievementsCacheTimestamp(
      String userId, DateTime timestamp) async {
    final key = '${_achievementsCachePrefix}all_$userId';
    return await _setTimestampForKey(key, timestamp);
  }

  /// Set timestamp for next achievement cache
  static Future<bool> setNextAchievementCacheTimestamp(
      String userId, DateTime timestamp) async {
    final key = '$_nextAchievementKey$userId';
    return await _setTimestampForKey(key, timestamp);
  }

  /// Set timestamp for achievement progress cache
  static Future<bool> setAchievementProgressCacheTimestamp(
      String userId, DateTime timestamp) async {
    final key = '$_progressKey$userId';
    return await _setTimestampForKey(key, timestamp);
  }

  /// Set timestamp for weekly challenge cache
  static Future<bool> setWeeklyChallengeCacheTimestamp(
      String userId, DateTime timestamp) async {
    final key = '$_weeklyChallengePrefix$userId';
    return await _setTimestampForKey(key, timestamp);
  }

  /// Set timestamp for mini challenges cache
  static Future<bool> setMiniChallengesCacheTimestamp(
      String userId, DateTime timestamp) async {
    final key = '$_miniChallengePrefix$userId';
    return await _setTimestampForKey(key, timestamp);
  }

  /// Set timestamp for friends activities cache
  static Future<bool> setFriendsActivitiesCacheTimestamp(
      List<String> userIds, DateTime timestamp) async {
    // Create cache key the same way as the datasource
    final sortedUserIds = List<String>.from(userIds)..sort();
    final key = '$_friendsActivitiesPrefix${sortedUserIds.join('_')}';
    return await _setTimestampForKey(key, timestamp);
  }

  /// Set timestamp for recent posts cache
  static Future<bool> setRecentPostsCacheTimestamp(DateTime timestamp) async {
    return await _setTimestampForKey(_recentPostsKey, timestamp);
  }

  // CONVENIENCE FUNCTIONS

  /// Set timestamp to current time for any cache type
  static Future<bool> setNewTimestamp(String cacheType, {String? userId, List<String>? userIds, DateTime? newTimestamp}) async {
    final timestamp = newTimestamp ?? DateTime.now().subtract(const Duration(seconds: 6));
    
    switch (cacheType) {
      case 'user':
        if (userId == null) throw ArgumentError('userId required for user cache');
        return await setUserCacheTimestamp(userId, timestamp);
      case 'all_users':
        return await setAllUsersCacheTimestamp(timestamp);
      case 'friends':
        if (userId == null) throw ArgumentError('userId required for friends cache');
        return await setFriendsCacheTimestamp(userId, timestamp);
      case 'all_achievements':
        if (userId == null) throw ArgumentError('userId required for achievements cache');
        return await setAllAchievementsCacheTimestamp(userId, timestamp);
      case 'next_achievement':
        if (userId == null) throw ArgumentError('userId required for next achievement cache');
        return await setNextAchievementCacheTimestamp(userId, timestamp);
      case 'achievement_progress':
        if (userId == null) throw ArgumentError('userId required for achievement progress cache');
        return await setAchievementProgressCacheTimestamp(userId, timestamp);
      case 'weekly_challenge':
        if (userId == null) throw ArgumentError('userId required for weekly challenge cache');
        return await setWeeklyChallengeCacheTimestamp(userId, timestamp);
      case 'mini_challenges':
        if (userId == null) throw ArgumentError('userId required for mini challenges cache');
        return await setMiniChallengesCacheTimestamp(userId, timestamp);
      case 'friends_activities':
        if (userIds == null) throw ArgumentError('userIds required for friends activities cache');
        return await setFriendsActivitiesCacheTimestamp(userIds, timestamp);
      case 'recent_posts':
        return await setRecentPostsCacheTimestamp(timestamp);
      default:
        throw ArgumentError('Unknown cache type: $cacheType');
    }
  }
}