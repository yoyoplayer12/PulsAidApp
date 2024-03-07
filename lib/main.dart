import 'package:flutter/material.dart';
import 'package:theapp/pages/language.dart';
import 'package:theapp/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Proxima-Soft'),
      home: const Language(),
      initialRoute: '/', // The route for the initial page of the app
      routes: {
        // '/': (context) => HomePage(),
        '/login': (context) => const LoginPage(), // Define the login page route
      },
    );
  }
}