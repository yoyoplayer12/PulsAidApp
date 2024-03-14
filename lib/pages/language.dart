import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/main.dart';
import 'package:theapp/components/header_logo.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String _selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const headerLogo(),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: Builder(
              builder: (BuildContext context) {
                return Text(
                  AppLocalizations.of(context).translate('choose_your_language'),
                  style: const TextStyle(
                    color: BrandColors.gray,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedLanguage = 'nederlands';
                if( _selectedLanguage == 'nederlands' ) {
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
                      style: TextStyle(fontSize: 16, color: BrandColors.gray),
                    ),
                  ),
                  Radio<String>(
                    value: 'nederlands',
                    groupValue: _selectedLanguage,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedLanguage = value!;
                          if( _selectedLanguage == 'nederlands' ) {
                            Locale newLocale = const Locale('nl');
                            MyApp.setLocale(context, newLocale);
                          }
                      });
                    },
                    activeColor: BrandColors.success,
                    fillColor: MaterialStateProperty.all(BrandColors.secondaryExtraDark),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedLanguage = 'english';
                if( _selectedLanguage == 'english' ) {
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
                      style: TextStyle(fontSize: 16, color: BrandColors.gray),
                    ),
                  ),
                  Radio<String>(
                    value: 'english',
                    groupValue: _selectedLanguage,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedLanguage = value!;
                          if( _selectedLanguage == 'english' ) {
                          Locale newLocale = const Locale('en');
                          MyApp.setLocale(context, newLocale);
                        }
                      });
                    },
                    activeColor: BrandColors.success,
                    fillColor: MaterialStateProperty.all(BrandColors.secondaryExtraDark),
                  ),
                ],
              ),
            ),
          ),
        ),
          Builder(
            builder: (context) => Container(
              // next button
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06, left: 30, right: 30),
              width: 400,
              child: ElevatedButtonBlue(
                onPressed: _selectedLanguage.isNotEmpty
                    ? () {
                        //add _selectedLanguage to session
                        Navigator.pushNamed(context, '/role');
                      }
                    : null, // If no language is selected, onPressed will be null
                arrow: true,
                child: Text(
                  AppLocalizations.of(context).translate('next'),
                  style: const TextStyle(
                    color: BrandColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}