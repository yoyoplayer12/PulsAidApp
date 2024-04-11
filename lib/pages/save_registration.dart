import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theapp/classes/registration_data.dart';
import 'package:theapp/classes/apimanager.dart';

class SaveRegistrationPage extends StatelessWidget {
  const SaveRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
  final registrationData = Provider.of<RegistrationData>(context).formData;

    ApiManager  apiManager = ApiManager();
    apiManager.createUser(registrationData).then((result) {
      if (result['status'] == 200) {
        Navigator.pushNamed(context, '/login');
      } 
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}