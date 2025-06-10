// import 'package:flutter/foundation.dart';
// import 'package:location/location.dart';

// class GetCurrentLocationUseCase {
//   Future<List<double>?> call() async {
//     final Location location = Location();
//     try {
//       // iOS-specific: Ensure location services are available
//       final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

//       // Step 1: Check location service status
//       bool serviceEnabled = await location.serviceEnabled();
//       if (!serviceEnabled) {
//         serviceEnabled = await location.requestService();
//         if (!serviceEnabled) {
//           debugPrint("Location services disabled by user");
//           return null;
//         }
//       }

//       if (isIOS) {
//         await location.requestPermission();
//         debugPrint("iOS-specific permission handling completed");
//       }

//       // Step 2: Handle permissions with iOS-specific states
//       PermissionStatus permission = await location.hasPermission();
//       debugPrint("Current permission status: $permission");

//       // Handle iOS permanent denial
//       if (permission == PermissionStatus.deniedForever) {
//         debugPrint("Location permissions permanently denied");
//         return null;
//       }

//       // Handle temporary denial or first-time request
//       else if (permission == PermissionStatus.denied) {
//         permission = await location.requestPermission();

//         // iOS: Allow "When In Use" status to proceed
//         if (permission != PermissionStatus.granted &&
//             permission != PermissionStatus.grantedLimited) {
//           debugPrint("Location permission denied by user");
//           return null;
//         }
//       }
//       else {
//         // Rest here
//         debugPrint("Location permission granted: $permission");
//         // try to await location.getLocation(); with try catch
//         try {
//           // PRINT "Entered try block to get location"
//           debugPrint("Entered try block to get location");
//           final LocationData currentLocation = await location.getLocation();
//           debugPrint("Current location: $currentLocation");
//           if (currentLocation.latitude == null || currentLocation.longitude == null) {
//             debugPrint("Invalid location data received");
//             return null;
//           }
//           return [
//             currentLocation.latitude ?? 40.37767,
//             currentLocation.longitude ?? 49.89201
//           ];
//         } catch (e) {
//           debugPrint("Error getting location: $e");
//         }
//         // If we reach here, it means we have valid permissions
//         // and can proceed to get the location
//         debugPrint("Location permission already granted");
//       }
//       // Step 3: Get location with fresh permissions
//       final LocationData locationData = await location.getLocation();
//       debugPrint("Location data received: $locationData");

//       // Step 4: Validate coordinates
//       if (locationData.latitude == null || locationData.longitude == null) {
//         debugPrint("Invalid location data received");
//         return null;
//       }

//       return [
//         locationData.latitude ?? 40.37767,
//         locationData.longitude ?? 49.89201
//       ];
//     } catch (e) {
//       debugPrint("Location error: $e");
//       return null;
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

// class GetCurrentLocationUseCase {
//   Future<List<double>?> call() async {
//     try {
//       // Step 1: Check if location services are enabled
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         debugPrint("Location services are disabled.");
//         return null;
//       }

//       // Step 2: Request/check permission
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           debugPrint("Location permission denied.");
//           return null;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         debugPrint("Location permission permanently denied.");
//         return null;
//       }

//       // Step 3: Define location settings
//       final locationSettings = LocationSettings(
//         accuracy: LocationAccuracy.best,   // Best available accuracy
//         distanceFilter: 0,                 // No distance filter
//       );

//       // Step 4: Wait for a moment to stabilize GPS
//       await Future.delayed(Duration(seconds: 1));

//       // Step 5: Get the location using updated API
//       Position position = await Geolocator.getCurrentPosition(
//         locationSettings: locationSettings,
//       );

//       debugPrint("Current location: lat=${position.latitude}, lon=${position.longitude}");

//       return [position.latitude, position.longitude];
//     } catch (e) {
//       debugPrint("Error fetching location: $e");
//       return null;
//     }
//   }
// }

import 'dart:math';

class GetCurrentLocationUseCase {
  Future<List<double>> call() async {
    try {
      debugPrint("[LocationUseCase] Step 1: Checking if location services are enabled...");
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint("[LocationUseCase] Location services are disabled.");
        return _getFallbackLeipzigLocation();
      }

      debugPrint("[LocationUseCase] Step 2: Checking location permission...");
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("[LocationUseCase] Location permission is denied. Requesting permission...");
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint("[LocationUseCase] User denied location permission.");
          return _getFallbackLeipzigLocation();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint("[LocationUseCase] Location permission is permanently denied.");
        return _getFallbackLeipzigLocation();
      }

      debugPrint("[LocationUseCase] Step 3: Setting location settings...");
      final locationSettings = LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 0,
      );

      debugPrint("[LocationUseCase] Step 4: Waiting briefly to stabilize GPS...");
      await Future.delayed(Duration(seconds: 1));

      debugPrint("[LocationUseCase] Step 5: Attempting to get current position...");
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      debugPrint("[LocationUseCase] Success! lat=${position.latitude}, lon=${position.longitude}");
      return [position.latitude, position.longitude];
    } catch (e) {
      debugPrint("[LocationUseCase] Error during location fetch: $e");
      return _getFallbackLeipzigLocation();
    }
  }

  /// Returns a randomly generated coordinate within Leipzig city bounds
  List<double> _getFallbackLeipzigLocation() {
    final random = Random();

    // Approximate latitude and longitude bounds for Leipzig, Germany
    double minLat = 51.30;
    double maxLat = 51.40;
    double minLon = 12.30;
    double maxLon = 12.45;

    double randomLat = minLat + random.nextDouble() * (maxLat - minLat);
    double randomLon = minLon + random.nextDouble() * (maxLon - minLon);

    debugPrint("[LocationUseCase] Returning fallback location in Leipzig: lat=$randomLat, lon=$randomLon");
    return [randomLat, randomLon];
  }
}