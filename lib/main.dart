import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/route_generator.dart';
import 'package:theapp/colors.dart';
import 'package:provider/provider.dart';
import 'package:theapp/classes/registration_data.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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