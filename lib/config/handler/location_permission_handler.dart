import 'package:geolocator/geolocator.dart';

class LocationPermissionHandler {
  const LocationPermissionHandler();

  Future<void> ensurePermissionGranted() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      switch (permission) {
        case LocationPermission.always:
        case LocationPermission.whileInUse:
          return;

        case LocationPermission.denied:
          throw Exception('Location permission denied.');

        case LocationPermission.deniedForever:
          throw Exception(
            'Location permission permanently denied. Please enable it from app settings.',
          );

        case LocationPermission.unableToDetermine:
          throw Exception('Unable to determine location permission.');
      }
    } catch (e) {
      rethrow;
    }
  }
}