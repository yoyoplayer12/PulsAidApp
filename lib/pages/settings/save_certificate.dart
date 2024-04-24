import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/animations/heart.dart';

class SaveCertificatesPage extends StatelessWidget {
    final Map<String, dynamic> formData;
  const SaveCertificatesPage({super.key, required this.formData});

  @override
  Widget build(BuildContext context) {

    ApiManager  apiManager = ApiManager();
    apiManager.addCertificate(formData).then((result) {
      if (result['status'] == 200) {
        Navigator.pushNamed(context, '/certificates');
      } 
    });
return Scaffold(
  backgroundColor: BrandColors.offWhiteDark,
  body: Align(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Voeg deze regel toe
      children: <Widget>[
        const Flexible(
          flex: 1,
          child: SizedBox(
            height: 250,
            child: HeartAnimation(),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              AppLocalizations.of(context).translate('welcome_hero'),
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    ),
  ),
);
  }
}