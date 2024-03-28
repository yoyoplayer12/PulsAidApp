import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/header_registration.dart';
import 'package:theapp/components/input_field.dart';
import 'package:theapp/components/input_formatters/date_input_formatter.dart';

class EhboRegistrationPage extends StatefulWidget {
  const EhboRegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EhboRegistrationPageState createState() => _EhboRegistrationPageState();
}

class _EhboRegistrationPageState extends State<EhboRegistrationPage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  String _dateError = "";

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameFocus.addListener(() {
      if (_firstNameFocus.hasFocus) {
        _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _lastNameFocus.addListener(() {
      if (_lastNameFocus.hasFocus) {
        _scrollController.animateTo(50.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _dobFocus.addListener(() {
      if (_dobFocus.hasFocus) {
        _scrollController.animateTo(100.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
  }

    @override
  void dispose() {
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _dobFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void onButtonClick() {
  var parts = _dobController.text.split('/');
  if (parts.length == 3) {
    var day = int.tryParse(parts[0]);
    var month = int.tryParse(parts[1]);
    var year = int.tryParse(parts[2]);

    // Validate the day
    if (day == null || day < 1 || day > 31) {
      setState(() {
        _dateError = 'Invalid day';
      });
      return;
    }

    // Validate the month
    if (month == null || month < 1 || month > 12) {
      setState(() {
        _dateError = 'Invalid month';
      });
      return;
    }

    // Validate the year
    var currentYear = DateTime.now().year;
    if (year == null || year < 1957 || year > currentYear) {
      setState(() {
        _dateError = 'Invalid year';
      });
      return;
    }

    // If the date is valid, clear the error message
    setState(() {
      _dateError = "";
    });
  } else {
    setState(() {
      _dateError = 'Invalid date';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child:
          Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child:
            Column(
              mainAxisSize : MainAxisSize.min,
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
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        controller: _firstNameController,
                        focusNode: _firstNameFocus,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                        textCapitalization: TextCapitalization.words,
                        onSubmitted: (String value) {
                          _lastNameFocus.requestFocus();
                        },
                      ),
                      CustomInputField(
                        labelText: 'last_name',
                        hintText: '',
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        controller: _lastNameController,
                        focusNode: _lastNameFocus,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                        onSubmitted: (String value) {
                          _dobFocus.requestFocus();
                        },
                      ),
                      Column(
                        children: [
                          CustomInputField(
                            labelText: 'date_of_birth',
                            hintText: 'dd/mm/yyyy',
                            isPassword: false,
                            keyboardType: TextInputType.datetime,
                            controller: _dobController,
                            focusNode: _dobFocus,
                            hasError: _dateError.isNotEmpty,
                            onSubmitted: (String value) {
                              onButtonClick();  // Call the validation logic when the user submits the keyboard
                            },
                            inputFormatters: [ DateInputFormatter() ],
                          ),
                          if (_dateError != "")
                            Text(
                              _dateError,
                              style: const TextStyle(color: Colors.red),
                            ),
                        ],
                      )
                    ],
                  ),
              ],
            ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.14,
              child:
            Container(
                    margin: const EdgeInsets.only(
                      left: 32,
                      right: 32,
                    ),
                    width: MediaQuery.of(context).size.width - 64,
                    child: Column(
                      children: [
                        Row(
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
                              width: 180,
                              child: ElevatedButtonBlue(
                                onPressed:
                                  _dateError.isEmpty &&
                                  _firstNameController.text.isNotEmpty &&
                                  _lastNameController.text.isNotEmpty &&
                                  _dobController.text.isNotEmpty
                                  ? () {
                                    Navigator.pushNamed(context, '/ehboRegistration2');
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
            Positioned(
            bottom: 32,
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
    );
  }
}
