import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theapp/classes/registration_data.dart';

class SaveRegistrationPage extends StatelessWidget {
  const SaveRegistrationPage({super.key});


  @override
  Widget build(BuildContext context) {
    final registrationData = Provider.of<RegistrationData>(context);


    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}