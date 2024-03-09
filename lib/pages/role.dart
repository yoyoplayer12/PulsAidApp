import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/radio_button.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';

class RolePage extends StatefulWidget {
  const RolePage({Key? key}) : super(key: key);

  @override
  _RolePageState createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  String _role = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              left: 32,
              right: 32,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 88,
                  child: ElevatedButtonGreyBack(
                    onPressed: () {
                      Navigator.pushNamed(context, '/language');
                    },
                    child: const Text('Terug'),
                  ),
                ),
                Container(
                  width: 179,
                  child: ElevatedButtonBlue(
                    onPressed: _role.isNotEmpty ? () {
                      if (_role == "EHBO") {
                        Navigator.pushNamed(context, '/login/ehbo');
                      } else {
                        Navigator.pushNamed(context, '/login/noehbo');
                      }
                    } : null,
                    child: const Text('Doorgaan'),
                    arrow: true,
                    textleft: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only( top: MediaQuery.of(context).size.height * 0.05,), // Change this to your desired margin
            child: RichText(
              text: TextSpan(
                text: 'Al een account? ',
                style: const TextStyle(
                  color: BrandColors.gray,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Login',
                    style: const TextStyle(
                      color: BrandColors.extraDarkCta, // Change this to your desired color
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, '/login');
                      },
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
            ),
            child: 
          DotProgressBar(currentStep: 1),
          ),
        ],
      ),
    );
  }
}
