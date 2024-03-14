import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/radio_button.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';

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
            child: Builder(
              builder: (BuildContext context) {
                return Text(
                  AppLocalizations.of(context).translate('how_would_you_like_to_help'),
                  style: const TextStyle(
                    color: BrandColors.gray,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                );
              },
            ),
          ),
          RadioButton(
            text: "EHBO_certificate",
            groupValue: _role,
            value: "EHBO",
            onChanged: (String? value) {
              setState(() {
                _role = value!;
              });
            },
          ),
          RadioButton(
            text: "continue_without",
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
                    child: const Text(''),
                  ),
                ),
                Container(
                  width: 179,
                  child: ElevatedButtonBlue(
                    onPressed: _role.isNotEmpty ? () {
                      if (_role == "EHBO") {
                        Navigator.pushNamed(context, '/ehboRegistration');
                      } else {
                        Navigator.pushNamed(context, '/roleAed');
                      }
                    } : null,
                    arrow: true,
                    textleft: true,
                     child: Builder(
                      builder: (BuildContext context) {
                        return Text(
                          AppLocalizations.of(context).translate('next'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only( top: MediaQuery.of(context).size.height * 0.05,), // Change this to your desired margin
            child:Builder(
              builder: (BuildContext context) {
                return RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context).translate('already_have_an_account'),
                    style: const TextStyle(
                      color: BrandColors.gray,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Login',
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
                );
              },
            ),
          ),
         Expanded(
            child: Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 64,  // reduce this value
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        alignment: Alignment.center,
                        child: DotProgressBar(currentStep: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
