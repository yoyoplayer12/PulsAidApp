import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/navbar.dart';

class DoNotDisturb extends StatefulWidget {
  const DoNotDisturb({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DoNotDisturbState createState() => _DoNotDisturbState();
}

class _DoNotDisturbState extends State<DoNotDisturb> {
  
//main content
  @override
Widget build(BuildContext context) {
  return Scaffold(
    bottomNavigationBar: Container(
      margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
      decoration: BoxDecoration(
        color: BrandColors.offWhiteLight,
        borderRadius: BorderRadius.circular(30), // Adjust the value as needed
      ),
      child: const CustomNavBar(
        selectedIndex: 1,
      ),
    ),
    body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
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
                      Navigator.pushNamed(
                        context,
                        '/notifications',
                      );
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