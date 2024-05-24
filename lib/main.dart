import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/route_generator.dart';
import 'package:theapp/colors.dart';
import 'package:provider/provider.dart';
import 'package:theapp/classes/registration_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/classes/route.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final route = MapsRoute();
Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? loggedin = prefs.getBool('loggedin');
  String language = prefs.getString('language') ?? 'en';
  // Set status bar brightness
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light, // Top bar brightness.
    ),
  );

  //location if platform is android
  if (Platform.isAndroid) {
    await initOneSignalAndLocation();
  }
  if (Platform.isIOS) {
    // OneSignal initialization
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID']!);
    OneSignal.Notifications.requestPermission(true);
    //prompt location
    OneSignal.Location.requestPermission();
    OneSignal.Location.setShared(true);
  }
  OneSignal.Notifications.addClickListener((event) async {
    var additionalData = event.notification.additionalData;
    var latitude = additionalData?['latitude'] ?? '0';
    var longitude = additionalData?['longitude'] ?? '0';
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    var firstPlaceMark = placemarks.first;
    var address = '${firstPlaceMark.street}';

    var navigatorState = navigatorKey.currentState;
    if (navigatorState != null && navigatorState.mounted) {
  showDialog(
    context: navigatorKey.currentState!.context,
    builder: (context) => AlertDialog(
      title: const Text('Someone is dying!'),
      content: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(address),
          ),
          SizedBox(
            width: 300.0, // adjust the width as needed
            height: 150.0, // adjust the height as needed
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('emergencyLocation'),
                  position: LatLng(latitude, longitude),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               ElevatedButtonBlue(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                arrow: false,
                child: Text(
                  AppLocalizations.of(context).translate('Busy'),
                  style: const TextStyle(
                    color: BrandColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              ElevatedButtonBlue(
                onPressed: () {
                  route.launchMapsUrl(latitude, longitude);
                },
                arrow: false,
                child: Text(
                  AppLocalizations.of(context).translate('Start'),
                  style: const TextStyle(
                    color: BrandColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
  });
  runApp(
    ChangeNotifierProvider(
      create: (context) => RegistrationData(),
      child: MyApp(loggedin: loggedin ?? false, language: language),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool loggedin;
  final String language;
  const MyApp({super.key, required this.loggedin, required this.language});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _MyAppState createState() =>
      _MyAppState(loggedin: loggedin, language: language);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  final bool loggedin;
  final String language;
  _MyAppState({required this.loggedin, required this.language});

  Locale _locale = const Locale('en', 'US');

  @override
  void initState() {
    if (loggedin) {
      super.initState();
      Locale newLocale =
          language == 'english' ? const Locale('en') : const Locale('nl');
      changeLocale(newLocale);
    }
  }

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      locale: _locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'PulsAid',
      theme: ThemeData(
        fontFamily: 'Proxima-Soft',
        scaffoldBackgroundColor: BrandColors.whiteLight,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: BrandColors.greyExtraLight,
          selectionColor: BrandColors.greyExtraLight,
          selectionHandleColor: BrandColors.greyExtraLight,
        ),
      ),
      initialRoute: loggedin
          ? '/home'
          : "/language", // The route for the initial page of the app

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('nl')],
    );
  }
}

//
//
//android location stuff
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
  Position? _currentPosition;
  // OneSignal initialization
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID']!);
  OneSignal.Notifications.requestPermission(true);

  try {
    _currentPosition = await _determinePosition();
    print('Current position: $_currentPosition');
    if (_currentPosition != null) {
      OneSignal.Location.setShared(true);
    }
  } catch (e) {
    print('Error determining position: $e');
  }
}
//end android location stuff
//
//