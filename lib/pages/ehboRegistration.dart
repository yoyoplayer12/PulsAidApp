import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/radio_button.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/header_registration.dart';

class EhboRegistrationPage extends StatefulWidget {
  const EhboRegistrationPage({Key? key}) : super(key: key);

  @override
  _EhboRegistrationPageState createState() => _EhboRegistrationPageState();
}

class _EhboRegistrationPageState extends State<EhboRegistrationPage> {
  String _role = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        const HeaderImageWithText(
            imageAsset: 'assets/images/background_header_login.png',
            title: 'registration',
            subtitle: 'personal_information',
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
                      Navigator.pushNamed(context, '/role');
                    },
                    child: const Text(''),
                  ),
                ),
                Container(
                  width: 179,
                  child: ElevatedButtonBlue(
                    onPressed: _role.isNotEmpty ? () {
                      if (_role == "AED") {
                        Navigator.pushNamed(context, '/registration/aed');
                      } else {
                        Navigator.pushNamed(context, '/registration/listener');
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
                        child: DotProgressBar(currentStep: 2),
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
