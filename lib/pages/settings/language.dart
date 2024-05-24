import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/classes/registration_data.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/main.dart';

Map<String, String> _formData = {
  'language': '',
};

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageSettingsState createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  @override
  void initState() {
    super.initState();
    _selectedLanguage = _formData['language'] ?? '';
  }
  String _selectedLanguage = '';

  updateLanguage(String language) {
   ApiManager apiManager = ApiManager();
    apiManager.updateLanguage(language).then((result) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            centerTitle: true,
            title:  Text(
              AppLocalizations.of(context).translate('language_preference'),
              style: const TextStyle(
                color: BrandColors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.transparent, // make the AppBar background transparent
            elevation: 0, // remove shadow
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 30.0), // adjust the value as needed
                child: IconButton(
                  icon: const Icon(Icons.close, size: 32, color: BrandColors.grey, semanticLabel: 'Exit'), // replace with your desired icon
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ]
          ),
          Container(
            margin: const EdgeInsets.only(top:65, left: 32, right: 32, bottom: 24),
            child: Builder(
              builder: (BuildContext context) {
                return Text(
                  AppLocalizations.of(context).translate('choose_your_language_info'),
                  style: const TextStyle(
                    color: BrandColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              updateLanguage('nederlands');
              setState(() {
                _selectedLanguage = 'nederlands';
                if( _selectedLanguage == 'nederlands' ) {
                  _formData['language'] = 'nederlands';
                  Provider.of<RegistrationData>(context, listen: false).updateFormData('language', 'nederlands');
                  Locale newLocale = const Locale('nl');
                  MyApp.setLocale(context, newLocale);
                }
              });
            },
           child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02, 
              left: 32,
              right: 32,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: BrandColors.secondaryExtraDark, // Set the border color
                width: 2, // Set the border width
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5), // Set your desired corner radius here
                      child: Image.asset(
                        'assets/images/dutch_flag.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Nederlands',
                      style: TextStyle(fontSize: 16, color: BrandColors.greyLight),
                    ),
                  ),
                  Radio<String>(
                    value: 'nederlands',
                    groupValue: _selectedLanguage,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedLanguage = value!;
                          if( _selectedLanguage == 'nederlands' ) {
                            updateLanguage('nederlands');
                            _formData['language'] = 'nederlands';
                            Provider.of<RegistrationData>(context, listen: false).updateFormData('language', 'nederlands');
                            Locale newLocale = const Locale('nl');
                            MyApp.setLocale(context, newLocale);
                          }
                      });
                    },
                    activeColor: BrandColors.semanticApple,
                    fillColor: MaterialStateProperty.all(BrandColors.secondaryExtraDark),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            updateLanguage('english');
            setState(() {
              _selectedLanguage = 'english';
                if( _selectedLanguage == 'english' ) {
                  Provider.of<RegistrationData>(context, listen: false).updateFormData('language', 'english');
                  _formData['language'] = 'english';
                  Locale newLocale = const Locale('en');
                  MyApp.setLocale(context, newLocale);
                }
            });
          },
          child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02, 
              left: 32,
              right: 32,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: BrandColors.secondaryExtraDark, // Set the border color
                width: 2, // Set the border width
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5), // Set your desired corner radius here
                      child: Image.asset(
                        'assets/images/english_flag.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'English',
                      style: TextStyle(fontSize: 16, color: BrandColors.greyLight),
                    ),
                  ),
                  Radio<String>(
                    value: 'english',
                    groupValue: _selectedLanguage,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedLanguage = value!;
                          if( _selectedLanguage == 'english' ) {
                          updateLanguage('english');
                          Provider.of<RegistrationData>(context, listen: false).updateFormData('language', 'english');
                          _formData['language'] = 'english';
                          Locale newLocale = const Locale('en');
                          MyApp.setLocale(context, newLocale);
                        }
                      });
                    },
                    activeColor: BrandColors.semanticApple,
                    fillColor: MaterialStateProperty.all(BrandColors.secondaryExtraDark),
                  ),
                ],
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}