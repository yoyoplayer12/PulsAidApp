import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/pages/navpages/notifications.dart';

class DoNotDisturb extends StatefulWidget {
  const DoNotDisturb({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DoNotDisturbState createState() => _DoNotDisturbState();
}

class _DoNotDisturbState extends State<DoNotDisturb> {
  
  //logincheck
  @override
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? loggedin = prefs.getBool('loggedin');
      if (loggedin == null || !loggedin) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, '/language');
        });
      }
    });
  }
//main content
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: <Widget>[
        
        Positioned(
        bottom: 180,
        left: 0, // This and the line below ensure the Text widget is centered horizontally
        right: 0,
          child: Center(
            child: Text(
              AppLocalizations.of(context).translate('you_have_no_calls'),
              style: const TextStyle(
                color: BrandColors.blackMid,
                fontSize: 16,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            AppBar(
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context).translate('completed_calls'),
                style: const TextStyle(
                  color: BrandColors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 30.0), // adjust the value as needed
                  child: IconButton(
                    icon: const Icon(Icons.notifications_none_sharp, size: 32, color: BrandColors.grey, semanticLabel: 'notifications'), // replace with your desired icon
                    onPressed: () {
                      // handle the icon tap here
                      Navigator.push(context, PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const Notifications(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(1.0, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ));
                    },
                  ),
                ),
              ],
              backgroundColor: Colors.transparent, // make the AppBar background transparent
              elevation: 0, // remove shadow
            ),
          ],
        ),
      ],
    ),
  );
}
}