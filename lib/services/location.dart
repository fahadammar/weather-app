import 'dart:html';

import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;

  Future<void> getLocation() async {
    // To get the current location
    LocationPermission checkPermission = await Geolocator.checkPermission();
    print("Permission: $checkPermission");
    if (checkPermission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.always ||
        checkPermission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    }
  }
}
