import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:theapp/pages/language.dart';
import 'package:theapp/pages/login.dart';
import 'package:theapp/pages/role.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
  // Set status bar brightness
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light, // Top bar brightness.
    ),
  );

  // OneSignal initialization
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID']!);
  OneSignal.Notifications.requestPermission(true);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PulsAid',
      theme: ThemeData(fontFamily: 'Proxima-Soft'),
      home: const Language(),
      initialRoute: '/', // The route for the initial page of the app
      routes: {
        // '/': (context) => HomePage(),
        '/language': (context) => const Language(), // Define the language page route
        '/role': (context) => const RolePage(), // Define the login page route
        '/login': (context) => const LoginPage(), // Define the login page route
      },
    );
  }
}
