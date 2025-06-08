import 'dart:convert';
import 'package:ch4nge/core/api/api_service.dart';
import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/data/models/activity/activity_model.dart';
import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IActivityDatasource {
  Future<List<ActivityEntity>> getFriendsActivities(List<String> userIds);
  Future<void> clearCache();
}

class ActivityRemote implements IActivityDatasource {
  final ApiService _apiService = ApiService.instance;
  static const String _cacheKeyPrefix = 'friends_activities_cache_';
  static const Duration _cacheValidityDuration = Duration(minutes: 30);

  @override
  Future<List<ActivityEntity>> getFriendsActivities(List<String> userIds) async {
    // Create a cache key based on the user IDs
    final sortedUserIds = List<String>.from(userIds)..sort();
    final cacheKey = '$_cacheKeyPrefix${sortedUserIds.join('_')}';
    
    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null) {
      List<ActivityModel> activitiesModel = cachedData
          .map((json) => ActivityModel.fromJson(json))
          .toList();
      
      return activitiesModel.map((activityModel) => activityModel.toEntity()).toList();
    }

    try {
      // Fetch from API
      final response = await _apiService.post(
        '/activities/friends',
        data: {
          'userIds': userIds,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
          },
          validateStatus: (status) => status! < 500,
        ),
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> activitiesData = response.data as List<dynamic>;

        final activities = activitiesData
            .map((json) => ActivityModel.fromJson(json))
            .toList();
        
        // Cache the data
        await _cacheData(cacheKey, activitiesData);

        List<ActivityEntity> activityEntities = activities
            .map((activityModel) => activityModel.toEntity())
            .toList();
        
        return activityEntities;
      } else {
        throw Exception('Failed to fetch friends activities: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails and we have no cache, return empty list or rethrow
      final cachedData = await _getCachedData(cacheKey, ignoreExpiry: true);
      if (cachedData != null) {
        List<ActivityModel> activitiesModel = cachedData
          .map((json) => ActivityModel.fromJson(json))
          .toList();      
        return activitiesModel.map((activityModel) => activityModel.toEntity()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    
    // Remove all friends activities cache keys
    for (final key in keys) {
      if (key.startsWith(_cacheKeyPrefix)) {
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