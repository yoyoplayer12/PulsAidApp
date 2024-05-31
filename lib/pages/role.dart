import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theapp/classes/registration_data.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/radio_button.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/header_logo.dart';

Map<String, String> _formData = {
  'role': '',
};

class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RolePageState createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  @override
  void initState() {
    super.initState();
    _role = _formData['role'] ?? '';
  }
  String _role = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const headerLogo(),
          Container(
            margin: const EdgeInsets.only(
              bottom: 32,
            ),
            child: Column(
              children: [
             Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.10,
              ),
              child: Builder(
                builder: (BuildContext context) {
                  return Text(
                    AppLocalizations.of(context).translate('how_would_you_like_to_help'),
                    style: const TextStyle(
                      color: BrandColors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
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
                _formData['role'] = value!;
                Provider.of<RegistrationData>(context, listen: false).updateFormData('role', value);
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
                _formData['role'] = value!;
                Provider.of<RegistrationData>(context, listen: false).updateFormData('role', value);
              },
            ),
          ],
        ),
      ),
          

          Expanded(
            flex: 1,
            child:
            Container(
                margin: const EdgeInsets.only(
                left: 32,
                right: 32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 88,
                    child: ElevatedButtonGreyBack(
                      onPressed: () {
                        Navigator.pushNamed(context, '/language');
                      },
                      child: const Text(''),
                    ),
                  ),
                  SizedBox(
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
          ),
          Expanded(
            flex: 1,
            child: 
            Container(
              margin: const EdgeInsets.only(
                top: 16,
              ),
              child:Builder(
                builder: (BuildContext context) {
                  return RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context).translate('already_have_an_account'),
                      style: const TextStyle(
                        color: BrandColors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            color: BrandColors.extraDarkCta, // Change this to your desired color
                            decoration: TextDecoration.underline,
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
          ),
          Expanded(
            flex: 1,
            child:
             Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 32,  // reduce this value
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        alignment: Alignment.center,
                        child: const DotProgressBar(totalSteps: 4, currentStep: 1),
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
