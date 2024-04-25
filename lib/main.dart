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
import 'package:theapp/pages/ehbo_registration2.dart';
import 'package:theapp/pages/ehbo_registration3.dart';
import 'package:theapp/pages/aed_registration.dart';
import 'package:theapp/pages/aed_registration2.dart';
import 'package:theapp/pages/save_registration.dart';
import 'package:theapp/pages/conversation.dart';
import 'package:theapp/pages/settings/account.dart';
import 'package:theapp/pages/settings/certificates.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theapp/app_localizations.dart';
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
      routes: {
        // '/': (context) => HomePage(),
        '/language': (context) => const Language(), // Define the language page route
        '/home': (context) => const Home(), // Define the home page route
        '/role': (context) => const RolePage(), // Define the role page route
        '/roleAed': (context) => const RoleAedPage(), // Define the roleAed page route
        '/ehboRegistration': (context) => const EhboRegistrationPage(), // Define the ehboRegistration page route
        '/ehboRegistration2': (context) => const EhboRegistration2Page(), // Define the ehboRegistration page route
        '/ehboRegistration3': (context) => const EhboRegistration3Page(), // Define the ehboRegistration page route
        '/aedRegistration': (context) => const AedRegistrationPage(), // Define the aedRegistration page route
        '/aedRegistration2': (context) => const AedRegistration2Page(), // Define the aedRegistration page route
        '/saveRegistration': (context) => const SaveRegistrationPage(), // Define the saveRegistration page route
        '/login': (context) => const LoginPage(), // Define the login page route
        '/notifications':(context) => const Notifications(), // Define the notifications page route
        '/doNotDisturb':(context) => const DoNotDisturb(), // Define the doNotDisturb page route
        '/instructions':(context) => const Instructions(), // Define the instructions page route
        '/account':(context) => const Account(), // Define the account page route
        '/conversation':(context) => const Conversation(), // Define the conversation page route
        '/accountSettings':(context) => const AccountSettings(), // Define the accountSettings page route
        '/certificates':(context) => const Certificates(), // Define the certificates page route
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