import 'dart:convert';
import 'package:ch4nge/core/api/api_service.dart';
import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/data/models/mini_challenge/mini_challenge_model.dart';
import 'package:ch4nge/features/layers/domain/entities/mini_challenge_entity.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IMiniChallengeDatasource {
  Future<List<MiniChallengeEntity>> getMiniChallenges(String userId);
  Future<void> clearCache();
}

class MiniChallengeRemote implements IMiniChallengeDatasource {
  final ApiService _apiService = ApiService.instance;
  static const String _cacheKeyPrefix = 'mini_challenges_cache_';
  static const Duration _cacheValidityDuration = Duration(hours: 1);

  @override
  Future<List<MiniChallengeEntity>> getMiniChallenges(String userId) async {
    final cacheKey = '$_cacheKeyPrefix$userId';

    final cachedData = await _getCachedData(cacheKey);
    if (cachedData != null) {
      List<MiniChallengeModel> miniChallengesModel =
          cachedData.map((json) => MiniChallengeModel.fromJson(json)).toList();

      return miniChallengesModel
          .map((miniChallengeModel) => miniChallengeModel.toEntity())
          .toList();
    }

    try {
      // Fetch from API
      final response = await _apiService.get(
        '/users/$userId/mini-challenges',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> miniChallengesData = response.data as List<dynamic>;
        List<MiniChallengeModel> miniChallenges = miniChallengesData
            .map((json) => MiniChallengeModel.fromJson(json))
            .toList();

        // Cache the data
        await _cacheData(cacheKey, miniChallengesData);

        List<MiniChallengeEntity> miniChallengeEntities = miniChallenges
            .map((miniChallengeModel) => miniChallengeModel.toEntity())
            .toList();

        return miniChallengeEntities;
      } else {
        throw Exception(
            'Failed to fetch mini challenges: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails and we have no cache, return empty list or rethrow
      final cachedData = await _getCachedData(cacheKey, ignoreExpiry: true);
      if (cachedData != null) {
        List<MiniChallengeModel> miniChallengesModel = cachedData
            .map((json) => MiniChallengeModel.fromJson(json))
            .toList();
        return miniChallengesModel
            .map((miniChallengeModel) => miniChallengeModel.toEntity())
            .toList();
      }
      rethrow;
    }
  }

  @override
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    // Remove all mini challenge-related cache keys
    for (final key in keys) {
      if (key.startsWith(_cacheKeyPrefix)) {
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
}
