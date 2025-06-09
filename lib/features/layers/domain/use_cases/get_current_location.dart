import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class GetCurrentLocationUseCase {
  Future<List<double>?> call() async {
    final Location location = Location();
    try {
      // iOS-specific: Ensure location services are available
      final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

      // Step 1: Check location service status
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          debugPrint("Location services disabled by user");
          return null;
        }
      }

      if (isIOS) {
        await location.requestPermission();
        debugPrint("iOS-specific permission handling completed");
      }

      // Step 2: Handle permissions with iOS-specific states
      PermissionStatus permission = await location.hasPermission();

      // Handle iOS permanent denial
      if (permission == PermissionStatus.deniedForever) {
        debugPrint("Location permissions permanently denied");
        return null;
      }

      // Handle temporary denial or first-time request
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();

        // iOS: Allow "When In Use" status to proceed
        if (permission != PermissionStatus.granted &&
            permission != PermissionStatus.grantedLimited) {
          debugPrint("Location permission denied by user");
          return null;
        }
      }

      // Step 3: Get location with fresh permissions
      final LocationData locationData = await location.getLocation();

      // Step 4: Validate coordinates
      if (locationData.latitude == null || locationData.longitude == null) {
        debugPrint("Invalid location data received");
        return null;
      }

      return [
        locationData.latitude ?? 40.37767,
        locationData.longitude ?? 49.89201
      ];
    } catch (e) {
      debugPrint("Location error: $e");
      return null;
    }
  }
}
