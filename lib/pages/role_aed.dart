import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/radio_button.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/header_logo.dart';
import 'package:theapp/classes/registration_data.dart';



Map<String, String> _formData = {
  'role': '',
};

class RoleAedPage extends StatefulWidget {
  const RoleAedPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RoleAedPageState createState() => _RoleAedPageState();
}

class _RoleAedPageState extends State<RoleAedPage> {
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
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.10,
            ),
            child: Builder(
              builder: (BuildContext context) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('how_would_you_like_to_help'),
                        style: const TextStyle(
                          color: BrandColors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 10), // Add some space between the text and the icon
                      const Icon(
                        Icons.info_outline,
                        color: BrandColors.grey,
                      ),
                    ],
                );
              },
            ),
          ),
          RadioButton(
            text: "go_get_an_aed",
            groupValue: _role,
            value: "AED",
            onChanged: (String? value) {
              setState(() {
                _role = value!;
              });
                _formData['role'] = value!;
                Provider.of<RegistrationData>(context, listen: false).updateFormData('role', value);
            },
          ),
          RadioButton(
            text: "Offers_an_online_listening_ear",
            groupValue: _role,
            value: "ListeningEar",
            onChanged: (String? value) {
              setState(() {
                _role = value!;
              });
                _formData['role'] = value!;
                Provider.of<RegistrationData>(context, listen: false).updateFormData('role', value);
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
                SizedBox(
                  width: 88,
                  child: ElevatedButtonGreyBack(
                    onPressed: () {
                      Navigator.pushNamed(context, '/role');
                    },
                    child: const Text(''),
                  ),
                ),
                SizedBox(
                  width: 179,
                  child: ElevatedButtonBlue(
                    onPressed: _role.isNotEmpty ? () {
                      if (_role == "AED") {
                        Navigator.pushNamed(context, '/aedRegistration');
                      } else {
                        Navigator.pushNamed(context, '/ear_registration');
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
