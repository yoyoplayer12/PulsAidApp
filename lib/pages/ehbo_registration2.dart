import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/header_registration.dart';
import 'package:theapp/components/input_field.dart';



class EhboRegistration2Page extends StatefulWidget {
  const EhboRegistration2Page({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EhboRegistrationPage2State createState() => _EhboRegistrationPage2State();
}

class _EhboRegistrationPage2State extends State<EhboRegistration2Page> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();
  String _emailError = '';
  String _passwordError = '';
  String _passwordConfirmationError = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _checkedemail = false;
  bool _checkedPassword = false;
  bool _checkedPasswordConfirmation = false;
  bool _emailNotFilled = false;
  bool _passwordNotFilled = false;
  bool _passwordConfirmationNotFilled = false;
  bool _allChecked = false;

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus) {
        _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus) {
        _scrollController.animateTo(50.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _confirmFocus.addListener(() {
      if (_confirmFocus.hasFocus) {
        _scrollController.animateTo(100.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _emailFocus.addListener(_onEmailFocusChange);
    _passwordFocus.addListener(_onPasswordFocusChange);
    _confirmFocus.addListener(_onConfirmFocusChange);
    
  }

    @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

bool isValidEmail(String value) {
  RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regex.hasMatch(value);
}

void _onEmailFocusChange() {
  if (!_emailFocus.hasFocus) {
    if (isValidEmail(_emailController.text)) {
      setState(() {
        _checkedemail = true;
        _emailError = '';
      });
    } else {
      setState(() {
        _checkedemail = false;
        _emailError = AppLocalizations.of(context).translate('invalid_email');
      });
    }
    checkFields();
  }
}

void _onPasswordFocusChange() {
  if (!_passwordFocus.hasFocus) {
    if (_passwordController.text.length < 8) {
      setState(() {
        _checkedPassword = false; 
        _passwordError = AppLocalizations.of(context).translate('password_too_short');
      });
    } else {
      setState(() {
        _checkedPassword = true;
        _passwordError = '';
      });
    }
    checkFields();
  }
}

void _onConfirmFocusChange() {
  if (!_confirmFocus.hasFocus) {
    if (_confirmController.text != _passwordController.text) {
      setState(() {
        _checkedPasswordConfirmation = false; 
        _passwordConfirmationError = AppLocalizations.of(context).translate('passwords_do_not_match');
      });
    } else {
      setState(() {
        _checkedPasswordConfirmation = true;
        _passwordError = '';
        _passwordConfirmationError = '';
      });
    }
    checkFields();
  }
}

void checkFieldsAndNavigate() {
  setState(() {
    _emailNotFilled = !_checkedemail;
    _passwordNotFilled = !_checkedPassword;
    _passwordConfirmationNotFilled = !_checkedPasswordConfirmation;
  });

  if (_emailNotFilled || _passwordNotFilled || _passwordConfirmationNotFilled) {
    return;
  } else {
    setState(() => _allChecked = true);
    Navigator.pushNamed(context, '/ehboRegistration2');
  }
}


void checkFields() {
  if(!_checkedemail || !_checkedPassword || !_checkedPasswordConfirmation) {
    setState(() {
      _allChecked = false;
    });
  } else {
    setState(() {
      _allChecked = true;
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
                  subtitle: 'account_information',
                ),
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children:[ 
                          Column(
                            children: [  CustomInputField(
                              labelText: 'email',
                              hintText: '',
                              isPassword: false,
                              keyboardType: TextInputType.text,
                              controller: _emailController,
                              focusNode: _emailFocus,
                              checked: _checkedemail,   
                              hasError: _emailError.isNotEmpty,
                              inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
                              onSubmitted: (String value) {
                                _passwordFocus.requestFocus();
                              },
                            ),
                            ],  
                          ),
                          if(_emailError.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(right: 36, top: 15),
                            child: Text(
                              AppLocalizations.of(context).translate("invalid_email"),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          if(_emailNotFilled && _emailError.isEmpty)
                          Container(
                            margin: const EdgeInsets.only(right: 36, top: 15),
                            child: Text(
                              AppLocalizations.of(context).translate("required_field"),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children:[ 
                          Column(
                            children: [  CustomInputField(
                              labelText: 'password',
                              hintText: '',
                              isPassword: true,
                              keyboardType: TextInputType.text,
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              checked: _checkedPassword,
                              hasError: _passwordError.isNotEmpty,
                              inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
                              onSubmitted: (String value) {
                                _confirmFocus.requestFocus();
                              },
                            ),
                            ],  
                          ),
                          if(_passwordError.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(right: 36, top: 15),
                            child: Text(
                              _passwordError,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          if(_passwordNotFilled && _passwordError.isEmpty)
                          Container(
                            margin: const EdgeInsets.only(right: 36, top: 15),
                            child: Text(
                              AppLocalizations.of(context).translate("required_field"),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children:[ 
                          Column(
                            children: [  CustomInputField(
                              labelText: 'confirm_password',
                              hintText: '',
                              isPassword: true,
                              keyboardType: TextInputType.text,
                              controller: _confirmController,
                              focusNode: _confirmFocus,
                              checked: _checkedPasswordConfirmation,
                              hasError: _passwordConfirmationError.isNotEmpty,
                              inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
                              onSubmitted: (String value) {  },
                            ),
                            if(_passwordConfirmationError.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.only(right: 36),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    AppLocalizations.of(context).translate("passwords_do_not_match"),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if(_passwordConfirmationNotFilled && _passwordConfirmationError.isEmpty)
                          Container(
                            margin: const EdgeInsets.only(right: 36, top: 15),
                            child: Text(
                              AppLocalizations.of(context).translate("required_field"),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                      ),
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
                                  Navigator.pushNamed(context, '/ehboRegistration');
                                },
                                child: const Text(''),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: GestureDetector(
                              onTap: checkFieldsAndNavigate,
                                child: ElevatedButtonBlue(
                                  onPressed: 
                                  _allChecked
                                    ? () {
                                      Navigator.pushNamed(context, '/ehboRegistration3');
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
                child: const DotProgressBar(currentStep: 3),
              ),
            ),
          ),
          ], 
          ),
      ),
    );
  }
}
