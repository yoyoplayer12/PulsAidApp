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
            height: MediaQuery.of(context).size.height * 0.56,
            child: Image.asset(
              'assets/images/start_image.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: const Text(
              'Choose your language',
              style: TextStyle(
                color: BrandColors.gray,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:10, left: 32, right: 32),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Set the border color
                width: 2, // Set the border width
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: ListTile(
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
          ),
          Container(
            margin: EdgeInsets.only(top:10, left: 32, right: 32),
            decoration: BoxDecoration(
              border: Border.all(
                color: BrandColors.secondaryExtraDark, // Set the border color
                width: 2, // Set the border width
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: ListTile(
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
          ),
          //add da button
          // Other widgets...
        ],
      ),
    );
  }
}