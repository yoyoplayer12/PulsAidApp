import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:theapp/components/buttons/Button_dark_blue.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/classes/route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

class EmergencyPage extends StatefulWidget {
  final double latitude;
  final double longitude;
  final int helpers;

  const EmergencyPage({super.key, 
    required this.latitude,
    required this.longitude,
    required this.helpers,
  });
  @override
  // ignore: library_private_types_in_public_api
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  String distanceInMeters = '0';
  String distance = '';
  String time = '';

  @override
  void initState() {
    super.initState();
    calculateDistance();
  }

  Future<void> calculateDistance() async {
    var userLocation = await Geolocator.getCurrentPosition();
    var url = Uri.parse(
        'http://router.project-osrm.org/route/v1/walking/${widget.longitude},${widget.latitude};${userLocation.longitude},${userLocation.latitude}?overview=false');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        distanceInMeters = jsonResponse['routes'][0]['distance'].toString();
        double distanceInKm = double.parse(distanceInMeters) / 1000;
        double avgSpeed = 5;
        double timeInHours = distanceInKm / avgSpeed;
        double timeInMinutes = timeInHours * 60;
        if (double.parse(distanceInMeters) < 10) {
          distance = 'Your Location';
          time = '';
          return;
        } else if (double.parse(distanceInMeters) < 1000) {
          // ignore: curly_braces_in_flow_control_structures
          distance = '(${double.parse(distanceInMeters).toStringAsFixed(0)} m)';
          time = '${timeInMinutes.toStringAsFixed(0)} min';
        } else {
          // ignore: curly_braces_in_flow_control_structures
          distance =
              '(${(double.parse(distanceInMeters) / 1000).toStringAsFixed(1)} km)';
          time = '${timeInMinutes.toStringAsFixed(0)} min';
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: BrandColors.whiteLight,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: BrandColors.whiteDark,
                  borderRadius:
                      BorderRadius.circular(8), // Add border radius here
                ),
                padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
                margin: const EdgeInsets.only(left: 32, right: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Center the content horizontally
                  children: [
                    SvgPicture.asset(
                      'assets/images/emergency_heart.svg',
                      width: 60.0,
                      height: 60.0,
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            widget.helpers.toString(),
                            style: const TextStyle(
                              height: 0.5,
                              fontSize: 36,
                              color: BrandColors.extraDarkCta,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Text(
                          'helpers',
                          style: TextStyle(
                            fontSize: 18,
                            color: BrandColors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: BrandColors.whiteDark,
                  borderRadius:
                      BorderRadius.circular(8), // Add border radius here
                ),
                margin: const EdgeInsets.only(top: 16, left: 32, right: 32, bottom: 16),
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder<List<Placemark>>(
                        future: placemarkFromCoordinates(
                            widget.latitude, widget.longitude),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            var firstPlaceMark = snapshot.data!.first;
                            var address = '${firstPlaceMark.street}';
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 19.5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: BrandColors.black,
                                      ),
                                      Text(
                                        address,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: BrandColors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 5.0, bottom: 24),
                                      child: Text(
                                        AppLocalizations.of(context).translate('Resuscitation'),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: BrandColors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 240, // adjust the height as needed
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(widget.latitude, widget.longitude),
                          zoom: 14.0,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('emergencyLocation'),
                            position: LatLng(widget.latitude, widget.longitude),
                          ),
                        },
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                            top: 24, left: 19.5, right: 19.5),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.account_circle_outlined,
                                    color: BrandColors.primaryGreenExtraDark,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 18),
                                  Text(
                                    time,
                                    style: const TextStyle(
                                      color: BrandColors.primaryGreenExtraDark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(distance,
                                      style: const TextStyle(
                                        color:
                                            BrandColors.primaryGreenExtraDark,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButtonDarkBlue(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    svgIcon: 'assets/images/heart_minus.svg',
                                    background: BrandColors.whiteDark,
                                    foreground: BrandColors.black,
                                    border: BrandColors.secondaryLight,
                                    child: Builder(
                                      builder: (BuildContext context) {
                                        return Text(
                                          AppLocalizations.of(context)
                                              .translate('Busy'),
                                          style: const TextStyle(
                                            color: BrandColors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButtonDarkBlue(
                                    onPressed: () {
                                      MapsRoute().launchMapsUrl(
                                          widget.latitude, widget.longitude);
                                    },
                                    svgIcon: 'assets/images/heart_check.svg',
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('Start'),
                                      style: const TextStyle(
                                        color: BrandColors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
