import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/checkbox.dart';
import 'package:theapp/components/navbar.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool _checkboxValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
        decoration: BoxDecoration(
          color: BrandColors.offWhiteLight,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const CustomNavBar(
          selectedIndex: 3,
        ),
      ),
      body: Column(
        children: [
          AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).translate('location'),
              style: const TextStyle(
                color: BrandColors.grayMid,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 30.0),
                child: IconButton(
                  icon: const Icon(Icons.close, size: 32, color: BrandColors.grayMid, semanticLabel: 'Exit'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 64, left: 32, right: 32),
            child: Text(
              AppLocalizations.of(context).translate('location_description'),
              style: const TextStyle(
                color: BrandColors.gray,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CustomCheckBox(
            text: 'allow_location',
            value: _checkboxValue,
            onChanged: (bool? value) {
              setState(() {
                _checkboxValue = value!;
              });
            },
          ), 
        ],
      ),
    );
  }
}