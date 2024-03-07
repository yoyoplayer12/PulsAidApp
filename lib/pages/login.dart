import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/radio_button.dart';
import 'package:theapp/components/buttons/button_blue.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _role = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container (
            width: double.infinity,
            child: Image.asset(
              'assets/images/header_login.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
            ),
            child: const Text(
              'Hoe wil jij helpen?',
              style: TextStyle(
                color: BrandColors.gray,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          RadioButton(
            text: "EHBO certificaat",
            groupValue: _role,
            value: "EHBO",
            onChanged: (String? value) {
              setState(() {
                _role = value!;
              });
            },
          ),
          RadioButton(
            text: "Doorgaan zonder",
            groupValue: _role,
            value: "NoEHBO",
            onChanged: (String? value) {
              setState(() {
                _role = value!;
              });
            },
          ),
        Row(
          children: [
            Container(
              width: 179,
              child: ElevatedButtonBlue(
                onPressed: () {
                  if (_role == "EHBO") {
                    Navigator.pushNamed(context, '/login/ehbo');
                  } else {
                    Navigator.pushNamed(context, '/login/noehbo');
                  }
                },
                child: const Text('Doorgaan'),
                arrow: true,
              ),
            ),
          ],
        ),
        ],
      ),
    );
  }
}