import 'package:location/location.dart';

class GetCurrentLocationUseCase {
  Future<List<double>?> call() async {
    final Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

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
    if (locationData.latitude != null && locationData.longitude != null) {
      return [
        locationData.latitude!,
        locationData.longitude!,
      ];
    }
    return null;
  }
}
