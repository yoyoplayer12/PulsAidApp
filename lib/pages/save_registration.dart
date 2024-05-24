import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/registration_data.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';

class SaveRegistrationPage extends StatelessWidget {
  const SaveRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
  final registrationData = Provider.of<RegistrationData>(context).formData;

    ApiManager  apiManager = ApiManager();
    apiManager.createUser(registrationData as Map<String, dynamic>).then((result) {
      if (result['status'] == 200) {
        Navigator.pushNamed(context, '/login');
      } 
    });
return Scaffold(
  backgroundColor: BrandColors.whiteDark,
  body: Align(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Voeg deze regel toe
      children: <Widget>[
        Flexible(
          flex: 1,
          child: SizedBox(
            height: 250,
            child: Image.asset('assets/images/person.png'),          
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