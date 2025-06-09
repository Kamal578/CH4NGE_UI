import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

/// Enhanced location service with iOS-specific improvements
class GetCurrentLocationUseCase {
  final Location _location = Location();
  
  /// Get current location with proper iOS handling
  Future<LocationResult> call({
    LocationAccuracy accuracy = LocationAccuracy.high,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    try {
      // Web handling - simpler flow
      if (kIsWeb) {
        final locationData = await _location.getLocation();
        final coordinates = _extractCoordinates(locationData);
        return coordinates != null 
          ? LocationResult.success(coordinates)
          : LocationResult.failure(LocationError.locationUnavailable);
      }

      // Check and request location service
      final serviceResult = await _handleLocationService();
      if (!serviceResult.isSuccess) {
        return LocationResult.failure(serviceResult.error!);
      }

      // Check and request permissions
      final permissionResult = await _handleLocationPermission();
      if (!permissionResult.isSuccess) {
        return LocationResult.failure(permissionResult.error!);
      }

      // Configure location settings for iOS optimization
      await _configureLocationSettings(accuracy);

      // Get location with timeout
      final locationData = await _location.getLocation().timeout(
        timeout,
        onTimeout: () => throw LocationError.timeout,
      );

      final coordinates = _extractCoordinates(locationData);
      return coordinates != null 
        ? LocationResult.success(coordinates)
        : LocationResult.failure(LocationError.locationUnavailable);

    } on LocationError catch (e) {
      return LocationResult.failure(e);
    } catch (e) {
      // Handle any other errors
      if (e.toString().contains('PERMISSION_DENIED')) {
        return LocationResult.failure(LocationError.permissionDenied);
      } else if (e.toString().contains('SERVICE_DISABLED')) {
        return LocationResult.failure(LocationError.serviceDisabled);
      }
      return LocationResult.failure(LocationError.unknown);
    }
  }

  /// Handle location service availability
  Future<ServiceResult> _handleLocationService() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      
      if (!serviceEnabled) {
        // On iOS, this will show an alert directing user to Settings
        serviceEnabled = await _location.requestService();
        
        if (!serviceEnabled) {
          return ServiceResult.failure(LocationError.serviceDisabled);
        }
      }
      
      return ServiceResult.success();
    } catch (e) {
      return ServiceResult.failure(LocationError.serviceUnavailable);
    }
  }

  /// Handle location permissions with iOS-specific logic
  Future<PermissionResult> _handleLocationPermission() async {
    try {
      PermissionStatus permission = await _location.hasPermission();
      
      // Handle denied forever case (iOS specific)
      if (permission == PermissionStatus.deniedForever) {
        return PermissionResult.failure(LocationError.permissionDeniedForever);
      }
      
      // Request permission if denied
      if (permission == PermissionStatus.denied) {
        permission = await _location.requestPermission();
        
        if (permission == PermissionStatus.deniedForever) {
          return PermissionResult.failure(LocationError.permissionDeniedForever);
        }
        
        if (permission != PermissionStatus.granted) {
          return PermissionResult.failure(LocationError.permissionDenied);
        }
      }
      
      return PermissionResult.success();
    } catch (e) {
      return PermissionResult.failure(LocationError.permissionUnavailable);
    }
  }

  /// Configure location settings optimized for iOS
  Future<void> _configureLocationSettings(LocationAccuracy accuracy) async {
    try {
      await _location.changeSettings(
        accuracy: accuracy,
        interval: 1000, // iOS ignores this, but good for consistency
        distanceFilter: 0, // Get all location updates
      );
    } catch (e) {
      // Settings configuration is optional, continue if it fails
      debugPrint('Location settings configuration failed: $e');
    }
  }

  /// Extract coordinates from LocationData
  List<double>? _extractCoordinates(LocationData locationData) {
    final lat = locationData.latitude;
    final lng = locationData.longitude;
    
    if (lat != null && lng != null) {
      // Basic validation for reasonable coordinates
      if (lat >= -90 && lat <= 90 && lng >= -180 && lng <= 180) {
        return [lat, lng];
      }
    }
    return null;
  }

  /// Get location stream for continuous updates
  Stream<LocationResult> getLocationStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) async* {
    try {
      // Configure settings
      await _configureLocationSettings(accuracy);
      
      await for (final locationData in _location.onLocationChanged) {
        final coordinates = _extractCoordinates(locationData);
        if (coordinates != null) {
          yield LocationResult.success(coordinates);
        } else {
          yield LocationResult.failure(LocationError.locationUnavailable);
        }
      }
    } catch (e) {
      yield LocationResult.failure(LocationError.streamError);
    }
  }

  /// Enable background location (use carefully on iOS)
  Future<bool> enableBackgroundMode({required bool enable}) async {
    try {
      return await _location.enableBackgroundMode(enable: enable);
    } catch (e) {
      debugPrint('Background mode configuration failed: $e');
      return false;
    }
  }
}

/// Result wrapper for location operations
class LocationResult {
  final List<double>? coordinates;
  final LocationError? error;
  final bool isSuccess;

  LocationResult.success(this.coordinates) 
    : error = null, 
      isSuccess = true;

  LocationResult.failure(this.error) 
    : coordinates = null, 
      isSuccess = false;

  /// Get latitude (first coordinate)
  double? get latitude => coordinates?[0];
  
  /// Get longitude (second coordinate)  
  double? get longitude => coordinates?[1];
}

/// Service availability result
class ServiceResult {
  final LocationError? error;
  final bool isSuccess;

  ServiceResult.success() : error = null, isSuccess = true;
  ServiceResult.failure(this.error) : isSuccess = false;
}

/// Permission check result
class PermissionResult {
  final LocationError? error;
  final bool isSuccess;

  PermissionResult.success() : error = null, isSuccess = true;
  PermissionResult.failure(this.error) : isSuccess = false;
}

/// Comprehensive error types for location operations
enum LocationError {
  permissionDenied,
  permissionDeniedForever,
  permissionUnavailable,
  serviceDisabled,
  serviceUnavailable,
  locationUnavailable,
  timeout,
  streamError,
  unknown;

  /// User-friendly error messages
  String get message {
    switch (this) {
      case LocationError.permissionDenied:
        return 'Location permission denied. Please grant location access.';
      case LocationError.permissionDeniedForever:
        return 'Location permission permanently denied. Please enable location access in Settings.';
      case LocationError.permissionUnavailable:
        return 'Unable to check location permissions.';
      case LocationError.serviceDisabled:
        return 'Location services are disabled. Please enable location services.';
      case LocationError.serviceUnavailable:
        return 'Location services are not available.';
      case LocationError.locationUnavailable:
        return 'Unable to determine current location.';
      case LocationError.timeout:
        return 'Location request timed out. Please try again.';
      case LocationError.streamError:
        return 'Error occurred while streaming location updates.';
      case LocationError.unknown:
        return 'An unknown error occurred while getting location.';
    }
  }

  /// Whether this error suggests the user should go to Settings
  bool get requiresSettingsAction {
    return this == LocationError.permissionDeniedForever || 
           this == LocationError.serviceDisabled;
  }
}