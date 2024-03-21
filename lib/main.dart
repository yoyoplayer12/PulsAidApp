import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:theapp/pages/language.dart';
import 'package:theapp/pages/login.dart';
import 'package:theapp/pages/navpages/do_not_disturb.dart';
import 'package:theapp/pages/navpages/instructions.dart';
import 'package:theapp/pages/navpages/account.dart';
import 'package:theapp/pages/navpages/notifications.dart';
import 'package:theapp/pages/role.dart';
import 'package:theapp/pages/role_aed.dart';
import 'package:theapp/pages/ehbo_registration.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theapp/components/navbar.dart';
import 'package:theapp/app_localizations.dart';
import 'pages/navpages/home.dart';

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
//global Variables (after user check ==> set these)
class GlobalVariables {
  static final GlobalVariables _singleton = GlobalVariables._internal();

  factory GlobalVariables() {
    return _singleton;
  }

  GlobalVariables._internal();

  bool loggedin = false;
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
      title: 'PulsAid',
      theme: ThemeData(fontFamily: 'Proxima-Soft'),
      home: const Navigation(
        pages: <Widget>[
          Home(),
          DoNotDisturb(),
          Instructions(),
          Account(),
        ],
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_alarm_outlined),
            label:  'Niet Storen',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            label: 'Instructies',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
      ),
      initialRoute: '/', // The route for the initial page of the app
      routes: {
        // '/': (context) => HomePage(),
        '/language': (context) => const Language(), // Define the language page route
        '/home': (context) => const Home(), // Define the home page route
        '/role': (context) => const RolePage(), // Define the role page route
        '/roleAed': (context) => const RoleAedPage(), // Define the roleAed page route
        '/ehboRegistration': (context) => const EhboRegistrationPage(), // Define the ehboRegistration page route
        '/login': (context) => const LoginPage(), // Define the login page route
        '/notifications':(context) => const Notifications(), // Define the notifications page route
      },
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