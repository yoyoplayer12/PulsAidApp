import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';
class Language extends StatelessWidget {
  const Language({super.key});

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
          Container(
            child: Text(
              'Choose your language',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: BrandColors.black,
              ),
            ),
          )
          // Other widgets...
        ],
      ),
      
    );
  }
}