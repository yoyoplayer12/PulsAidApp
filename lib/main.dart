import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/route_generator.dart';
import 'pages/navpages/home.dart';
import 'package:theapp/colors.dart';
import 'package:provider/provider.dart';
import 'package:theapp/classes/registration_data.dart';


Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(ChangeNotifierProvider(
      create: (context) => RegistrationData(),
      child: const MyApp(),
    ),);
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
//global Variables (after user check ==> set these)
class GlobalVariables {
  static final GlobalVariables _singleton = GlobalVariables._internal();

  factory GlobalVariables() {
    return _singleton;
  }

  GlobalVariables._internal();

  static bool loggedin = false;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }


}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', 'US');
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
      home: const Home(),
      initialRoute: '/', // The route for the initial page of the app

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