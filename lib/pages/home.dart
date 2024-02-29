import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log In',
          style: TextStyle(
            color: BrandColors.black,
            fontSize: 24,
            fontWeight: FontWeight.w300,

          ),
        ),
      ),
    );
  }
}