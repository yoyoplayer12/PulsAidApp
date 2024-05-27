import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:theapp/pages/emergency_notification.dart';

class LocationOneSignalSetup {
  final BuildContext context;
  late SharedPreferences prefs;
   LocationOneSignalSetup(this.context) {
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> initOneSignal() async {
    if (Platform.isAndroid) {
      await initOneSignalAndLocation();
    }
    if (Platform.isIOS) {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
      OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID']!);
      OneSignal.Notifications.requestPermission(true);
      OneSignal.Location.requestPermission();
      OneSignal.Location.setShared(true);
    }
    OneSignal.Notifications.addClickListener((event) async {
      var additionalData = event.notification.additionalData;
      try {
        var latitude = additionalData?['latitude'] as double? ?? 0;
        var longitude = additionalData?['longitude'] as double? ?? 0;
        var emergencyId = additionalData?['emergencyId'] as String? ?? '';
        var route = additionalData?['route'] as String? ?? '';
        print('EMERGENCy:' + emergencyId);
        var userId = prefs?.getString('user') ?? '';
        print('USER:' + userId);
        print('ROUTE:' + route);
        print('LAT:' + latitude.toString());

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EmergencyPage(latitude: latitude, longitude: longitude, helpers: 0, emergencyId: emergencyId, userId: userId ),
        ));
      } catch (e) {
        print('Error: $e');
      }
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> initOneSignalAndLocation() async {
    Position? currentPosition;
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID']!);
    OneSignal.Notifications.requestPermission(true);

    try {
      currentPosition = await _determinePosition();
      print('Current position: $currentPosition');
      if (currentPosition != null) {
        OneSignal.Location.setShared(true);
      }
    } catch (e) {
      print('Error determining position: $e');
    }
  }
}