import 'package:flutter/material.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/header_registration.dart';
import 'package:theapp/components/input_field.dart';

class EhboRegistrationPage extends StatefulWidget {
  const EhboRegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EhboRegistrationPageState createState() => _EhboRegistrationPageState();
}

class _EhboRegistrationPageState extends State<EhboRegistrationPage> {
  final String  _role = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Column(
        children: [
        const HeaderImageWithText(
            imageAsset: 'assets/images/background_header_login.png',
            title: 'registration',
            subtitle: 'personal_information',
          ),
            Column(
              children: [
                CustomInputField(
                  labelText: 'first_name',
                  hintText: '',
                  controller: TextEditingController(),
                ),
                CustomInputField(
                  labelText: 'last_name',
                  hintText: '',
                  controller: TextEditingController(),
                ),
                CustomInputField(
                  labelText: 'date_of_birth',
                  hintText: 'dd-mm-yyyy',
                  controller: TextEditingController(),
                ),  
              ],
            ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(
                left: 32,
                right: 32,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        width: 180,
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
                ],
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
                        child: const DotProgressBar(currentStep: 2),
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
