import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_blue.dart';

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
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
            child: const Text(
              'Choose your language',
              style: TextStyle(
                color: BrandColors.gray,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedLanguage = 'nederlands';
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5), // Set your desired corner radius here
                      child: Image.asset(
                        'assets/images/dutch_flag.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5), // Set your desired corner radius here
              child: Image.asset(
                'assets/images/english_flag.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
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
          Container(
            // next button
            margin: const EdgeInsets.only(top: 10),
            child:  ElevatedButtonBlue(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}