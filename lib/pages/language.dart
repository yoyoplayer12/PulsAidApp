import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String _selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/start_image.png',
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            'Choose your language',
            style: TextStyle(
              color: BrandColors.gray,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          ListTile(
            title: const DefaultTextStyle(
              style: TextStyle(fontSize: 16, color: BrandColors.gray),
              child: Text('English'),
            ),
            leading: Radio<String>(
              value: 'english',
              groupValue: _selectedLanguage,
              onChanged: (String? value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
              activeColor: BrandColors.success,
            ),
          ),
          ListTile(
            title: const DefaultTextStyle(
              style: TextStyle(fontSize: 16, color: BrandColors.gray),
              child: Text('Nederlands'),
            ),
            leading: Radio<String>(
              value: 'nederlands',
              groupValue: _selectedLanguage,
              onChanged: (String? value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
              activeColor: BrandColors.success,
            ),
          ),
          //add da button
          // Other widgets...
        ],
      ),
    );
  }
}