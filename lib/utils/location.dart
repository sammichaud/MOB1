import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude = 0;
  late double longitude = 0;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
