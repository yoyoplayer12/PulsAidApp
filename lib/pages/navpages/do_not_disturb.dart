import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/main.dart';
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
  void initState() {
    super.initState();
    if (false == GlobalVariables.loggedin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/language');
      });
    }
  }
//main content
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            AppBar(
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context).translate('availability'),
                style: const TextStyle(
                  color: BrandColors.grayMid,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 30.0), // adjust the value as needed
                  child: IconButton(
                    icon: const Icon(Icons.notifications_none_sharp, size: 32, color: BrandColors.grayMid, semanticLabel: 'notifications'), // replace with your desired icon
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