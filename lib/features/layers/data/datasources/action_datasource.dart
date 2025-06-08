import 'package:ch4nge/core/api/api_service.dart';
import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/data/models/action/actions/green_model.dart/green_model.dart';
import 'package:ch4nge/features/layers/data/models/action/actions/transportation_model.dart/transportation_model.dart';
import 'package:dio/dio.dart';

abstract class IActionDatasource {
  Future<void> uploadGreenAction(GreenModel action);
  Future<void> uploadTransportationAction(TransportationModel action);
}

class ActionRemoteDatasource implements IActionDatasource {
  final ApiService _apiService = ApiService.instance;

  @override
  Future<void> uploadTransportationAction(TransportationModel action) async {
    try {
      final actionDTO = action.toActionDTO();
      final jsonData = actionDTO.toJson();

      final response = await _apiService.post(
        '/actions/transportation',
        data: jsonData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
            'Failed to upload transportation action: ${response.statusCode} - ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception(
            'Network error uploading transportation action: ${e.message} - ${e.response?.data}');
      }
      rethrow;
    }
  }

  @override
  Future<void> uploadGreenAction(GreenModel action) async {
    try {
      final actionDTO = action.toActionDTO();
      final jsonData = actionDTO.toJson();

      final response = await _apiService.post(
        '/actions/green',
        data: jsonData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
            'Failed to upload green action: ${response.statusCode} - ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception(
            'Network error uploading green action: ${e.message} - ${e.response?.data}');
      }
      rethrow;
    }
  }
}
