import 'dart:convert';
import 'package:ch4nge/core/api/api_service.dart';
import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/data/models/achievement/achievement_model.dart';
import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAchievementsDatasource {
  Future<List<AchievementEntity>> getAllAchievements(String userId);
  Future<AchievementEntity> getNextAchievement(String userId);
  Future<List<AchievementEntity>> getAchievementProgress(String userId);
  Future<void> clearCache();
}

class AchievementsRemote implements IAchievementsDatasource {
  final ApiService _apiService = ApiService.instance;
  static const String _cacheKeyPrefix = 'achievements_cache_';
  static const String _nextAchievementKey = 'next_achievement_';
  static const String _progressKey = 'achievement_progress_';
  static const Duration _cacheValidityDuration = Duration(hours: 1);

  @override
  Future<List<AchievementEntity>> getAllAchievements(String userId) async {
    final cacheKey = '${_cacheKeyPrefix}all_$userId';
    
    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null) {
      List<AchievementModel> achievementsModel = cachedData
          .map((json) => AchievementModel.fromJson(json))
          .toList();
      
      return achievementsModel.map((achievementModel) => achievementModel.toEntity()).toList();
    }

    try {
      // Fetch from API
      final response = await _apiService.get(
        '/users/$userId/achievements',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
          },
          validateStatus: (status) => status! < 500,
        ),
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> achievementsData = response.data as List<dynamic>;
        final achievements = achievementsData
            .map((json) => AchievementModel.fromJson(json))
            .toList();
        
        // Cache the data
        await _cacheData(cacheKey, achievementsData);

        List<AchievementEntity> achivementsEntities = achievements
            .map((achievementModel) => achievementModel.toEntity())
            .toList();
        
        return achivementsEntities;
      } else {
        throw Exception('Failed to fetch achievements: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails and we have no cache, return empty list or rethrow
      final cachedData = await _getCachedData(cacheKey, ignoreExpiry: true);
      if (cachedData != null) {
        List<AchievementModel> achievementsModel = cachedData
          .map((json) => AchievementModel.fromJson(json))
          .toList();      
        return achievementsModel.map((achievementModel) => achievementModel.toEntity()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<AchievementEntity> getNextAchievement(String userId) async {
    final cacheKey = '$_nextAchievementKey$userId';
    
    // Try to get from cache first
    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null && cachedData.isNotEmpty) {
      return AchievementModel.fromJson(cachedData.first).toEntity();
    }

    try {
      // Fetch from API
      final response = await _apiService.get(
        '/users/$userId/achievements/next',
         options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
          },
          validateStatus: (status) => status! < 500,
        ),
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final achievementData = response.data as Map<String, dynamic>;
        final achievement = AchievementModel.fromJson(achievementData);
        
        // Cache the data
        await _cacheData(cacheKey, [achievementData]);

        AchievementEntity achievementEntity = achievement.toEntity();
        
        return achievementEntity;
      } else {
        throw Exception('Failed to fetch next achievement: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails and we have no cache, rethrow
      final cachedData = await _getCachedData(cacheKey, ignoreExpiry: true);
      if (cachedData != null && cachedData.isNotEmpty) {
        return AchievementModel.fromJson(cachedData.first).toEntity();
      }
      rethrow;
    }
  }

  @override
  Future<List<AchievementEntity>> getAchievementProgress(String userId) async {
    final cacheKey = '$_progressKey$userId';
    
    // Try to get from cache first
    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null) {
      return cachedData.map((json) => AchievementModel.fromJson(json).toEntity()).toList();
    }

    try {
      // Fetch from API
      final response = await _apiService.get(
        '/users/$userId/achievements/progress',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
          },
        validateStatus: (status) => status! < 500,
        ),
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> progressData = response.data as List<dynamic>;
        final progress = progressData
            .map((json) => AchievementModel.fromJson(json))
            .toList();
        
        // Cache the data
        await _cacheData(cacheKey, progressData);

        List<AchievementEntity> progressEntities = progress
            .map((achievementModel) => achievementModel.toEntity())
            .toList();

        return progressEntities;
      } else {
        throw Exception('Failed to fetch achievement progress: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails and we have no cache, return empty list or rethrow
      final cachedData = await _getCachedData(cacheKey, ignoreExpiry: true);
      if (cachedData != null) {
        return cachedData.map((json) => AchievementModel.fromJson(json).toEntity()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    
    // Remove all achievement-related cache keys
    for (final key in keys) {
      if (key.startsWith(_cacheKeyPrefix) || 
          key.startsWith(_nextAchievementKey) || 
          key.startsWith(_progressKey)) {
        await prefs.remove(key);
      }
    }
  }

  Future<List<dynamic>?> _getCachedData(String key, {bool ignoreExpiry = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedString = prefs.getString(key);
      
      if (cachedString == null) return null;
      
      final cachedMap = jsonDecode(cachedString) as Map<String, dynamic>;
      final timestamp = DateTime.fromMillisecondsSinceEpoch(cachedMap['timestamp']);
      final data = cachedMap['data'] as List<dynamic>;
      
      // Check if cache is still valid
      if (!ignoreExpiry && DateTime.now().difference(timestamp) > _cacheValidityDuration) {
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
}