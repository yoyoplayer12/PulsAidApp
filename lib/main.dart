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

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? loggedin = prefs.getBool('loggedin');
  runApp(ChangeNotifierProvider(
      create: (context) => RegistrationData(),
      child: MyApp(loggedin: loggedin ?? false),
    ),);
  // Set status bar brightness
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light, // Top bar brightness.
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool loggedin;
  const MyApp({super.key, required this.loggedin});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _MyAppState createState() => _MyAppState(loggedin: loggedin);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }


}

class _MyAppState extends State<MyApp> {
  final bool loggedin;
  _MyAppState({required this.loggedin});

  Locale _locale = const Locale('en', 'US');
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    initOneSignalAndLocation();
  }

  Future<void> initOneSignalAndLocation() async {
    // OneSignal initialization
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID']!);
    OneSignal.Notifications.requestPermission(true);

    try {
      _currentPosition = await _determinePosition();
      print('Current position: $_currentPosition');
      if(_currentPosition != null){
         OneSignal.Location.setShared(true);
      }
    } catch (e) {
      print('Error determining position: $e');
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
      locale: _locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'PulsAid',
      theme: ThemeData(
        fontFamily: 'Proxima-Soft',
        scaffoldBackgroundColor: BrandColors.white,
            textSelectionTheme: const TextSelectionThemeData(
            cursorColor: BrandColors.grayLight,
            selectionColor: BrandColors.grayLight,
            selectionHandleColor: BrandColors.grayLight,
          ),
        ),
      initialRoute: loggedin ? '/home' : "/login", // The route for the initial page of the app

      localizationsDelegates: const[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,  
      ],
      supportedLocales: const[
        Locale('en'),
        Locale('nl')
      ],
    );
  }
}