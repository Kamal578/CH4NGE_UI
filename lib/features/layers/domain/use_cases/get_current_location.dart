import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class GetCurrentLocationUseCase {
  Future<List<double>?> call() async {
    final Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    if (kIsWeb) {
      try {
        final LocationData locationData = await location.getLocation();
        return _extractCoordinates(locationData);
      } catch (_) {
        return null;
      }
    }

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check for location permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    final LocationData locationData = await location.getLocation();
    return _extractCoordinates(locationData);
  }

  List<double>? _extractCoordinates(LocationData locationData) {
    if (locationData.latitude != null && locationData.longitude != null) {
      return [locationData.latitude!, locationData.longitude!];
    }
    return null;
  }
}
