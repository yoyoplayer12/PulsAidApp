import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';

class RateProcess extends StatefulWidget {
  const RateProcess({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RateProcessState createState() => _RateProcessState();
}

class _RateProcessState extends State<RateProcess> {
  
//main content
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body:
      
          
           AppBar(
              centerTitle: true,
              title: Container(
                margin: const EdgeInsets.only(left: 16.0), // adjust the value as needed
                child: Text(
                  AppLocalizations.of(context).translate('resuscitation'),
                  style: const TextStyle(
                    color: BrandColors.grayMid,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent, // make the AppBar background transparent
              elevation: 0, // remove shadow
              automaticallyImplyLeading: false,
              actions: <Widget>[
                 Container(
                  margin: const EdgeInsets.only(right: 16.0), // adjust the value as needed
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 32, color: BrandColors.grayMid, semanticLabel: 'Exit'), // replace with your desired icon
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ]
            ),
        );
}
}