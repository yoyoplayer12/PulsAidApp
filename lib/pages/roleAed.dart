import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/radio_button.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';

class RoleAedPage extends StatefulWidget {
  const RoleAedPage({Key? key}) : super(key: key);

  @override
  _RoleAedPageState createState() => _RoleAedPageState();
}

class _RoleAedPageState extends State<RoleAedPage> {
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
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('how_would_you_like_to_help'),
                        style: const TextStyle(
                          color: BrandColors.gray,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 10), // Add some space between the text and the icon
                      Icon(
                        Icons.info_outline,
                        color: BrandColors.gray,
                      ),
                    ],
                );
              },
            ),
          ),
          RadioButton(
            text: "go_get_an_aed",
            groupValue: _role,
            value: "EHBO",
            onChanged: (String? value) {
              setState(() {
                _role = value!;
              });
            },
          ),
          RadioButton(
            text: "Offers_an_online_listening_ear",
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
