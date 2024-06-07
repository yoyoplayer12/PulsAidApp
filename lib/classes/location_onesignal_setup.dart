import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:theapp/pages/emergency_notification.dart';
import 'package:theapp/pages/navpages/notifications.dart';


class LocationOneSignalSetup {
  final BuildContext context;
  late SharedPreferences prefs;

  LocationOneSignalSetup._(this.context);

  static Future<LocationOneSignalSetup> create(BuildContext context) async {
    var setup = LocationOneSignalSetup._(context);
    await setup.initSharedPreferences();
    return setup;
  }

  Future<void> initSharedPreferences() async {
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
        var conversationPlatform = additionalData?['platform'] as String? ?? '';

        var helpersCount = 0;
        print('HELPERS COUNT: $helpersCount');
        var userId = prefs.getString('user') ?? '';
        if(conversationPlatform != '') {
          Navigator.pushNamed(context, "/conversationLoaderEar", arguments: conversationPlatform);
        }
        else if(emergencyId != '') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EmergencyPage(latitude: latitude, longitude: longitude, emergencyId: emergencyId, userId: userId ),
          ));
        }else{
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Notifications(),
          ));
        }
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

    var externalUserId = prefs.getString('user') ?? '';


    // Setting External User Id with Callback Available in SDK Version 3.9.3+
    OneSignal.User.addAlias('external_id', externalUserId);

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