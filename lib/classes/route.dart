import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapsRoute {
  Future<void> launchMapsUrl(double latitude, double longitude) async {
    //get user location
    var userLocation = await Geolocator.getCurrentPosition();
    var userAdress = await placemarkFromCoordinates(userLocation.latitude, userLocation.longitude);
    var destinationAdress = await placemarkFromCoordinates(latitude, longitude);
    var userAdressFinal = userAdress.first.street;
    var destinationAdressFinal = destinationAdress.first.street;
    if (Platform.isAndroid) {
      final Uri googleMapsUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl);
      } else {
        throw 'Could not launch $googleMapsUrl';
      }
    } else if (Platform.isIOS) {
      final Uri appleMapsUrl = Uri.parse("https://maps.apple.com/?saddr=$userAdressFinal&daddr=$destinationAdressFinal");
      if (await canLaunchUrl(appleMapsUrl)) {
        await launchUrl(appleMapsUrl);
      } else {
        throw 'Could not launch $appleMapsUrl';
      }
    }
  }
}