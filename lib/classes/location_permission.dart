import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionHandler {
  loc.Location location = loc.Location();
  bool hasOpenedSettings = false;
  
  Future<void> requestLocationPermission(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasAskedForPermission = prefs.getBool('hasAskedForPermission') ?? false;

    if (!hasAskedForPermission) {
      if (Platform.isIOS) {
        // For iOS, request "Always Allow" permission
        loc.PermissionStatus permission = await location.requestPermission();
        print(permission);
        if (permission == loc.PermissionStatus.granted ||
            permission == loc.PermissionStatus.grantedLimited ||
            permission == loc.PermissionStatus.denied) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // Add a StatefulBuilder here
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    title: const Text('Full location Permissions Required'),
                    content: const Text('This app needs full location permissions to function. Please open settings and set location permissions to always allow for this app.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Open Settings'),
                        onPressed: () {
                          // Open the app settings page
                          openAppSettings();
                          // Wait for 2 seconds before setting the flag to true
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              hasOpenedSettings = true;
                            });
                          });
                        },
                      ),
                      // Show the "Done" button only if the "Open Settings" button has been clicked
                      if (hasOpenedSettings)
                        TextButton(
                          child: const Text('Done'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                    ],
                  );
                },
              );
            },
          );
        }
      } else {
        // For other platforms, request regular permission
        LocationPermission permission = await Geolocator.requestPermission();
        print(permission);
        if (permission != LocationPermission.always) {
          // Show the dialog if permission is not granted
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Location Permissions Required'),
                content: const Text(
                    'This app needs location permissions to function. Please grant location permission.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Grant Permission'),
                    onPressed: () {
                      // Open the app settings page
                      openAppSettings();
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }

      await prefs.setBool('hasAskedForPermission', true);
    }
  }
}