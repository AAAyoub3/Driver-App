import 'dart:async';
import 'dart:io';

import 'package:flowery/modules/order_tracking/data/data_sources/firestore_data_source.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@singleton
class LocationService {
  final FirestoreDataSource _firestoreDataSource;
  StreamSubscription<Position>? _positionSubscription;

  LocationService(this._firestoreDataSource);

  Future<void> startTracking(String driverId) async {
    await _positionSubscription?.cancel();
    _positionSubscription = null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    // Write current position immediately — don't wait for the device to move
    try {
      final current = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      await _firestoreDataSource.updateDriverLocation(
        driverId: driverId,
        lat: current.latitude,
        lng: current.longitude,
        accuracy: current.accuracy,
      );
    } catch (_) {}

    // Then keep updating on movement (+ time interval on Android)
    final locationSettings = Platform.isAndroid
        ? AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
            intervalDuration: const Duration(seconds: 15),
          )
        : const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
          );

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (position) {
        _firestoreDataSource.updateDriverLocation(
          driverId: driverId,
          lat: position.latitude,
          lng: position.longitude,
          accuracy: position.accuracy,
        );
      },
      onError: (_) {},
    );
  }

  void stopTracking() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
  }
}
