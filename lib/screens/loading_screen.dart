import 'dart:html';

import 'package:flutter/material.dart';
// Geolocation
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getLocation();
    print("Latitude: ${location.latitude}");
    print("Longitude: ${location.longitude}");
  }

  void buttonLocationTap() async {
    LocationPermission checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.always ||
        checkPermission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print("CurrentLocation: $position");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            buttonLocationTap();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
