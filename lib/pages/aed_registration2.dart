import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/classes/registration_data.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/header_registration.dart';
import 'package:theapp/components/input_field.dart';

Map<String, String> _formData = {
  'email': '',
  'password': '',
  'confirm_password': '',
  'privacy': 'false',
};


class AedRegistration2Page extends StatefulWidget {
  const AedRegistration2Page({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AedRegistrationPage2State createState() => _AedRegistrationPage2State();
}

class _AedRegistrationPage2State extends State<AedRegistration2Page> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();
  String _emailError = '';
  String _passwordError = '';
  String _passwordConfirmationError = '';
  bool checkedValue = false;

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
      if (_emailFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(50.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _confirmFocus.addListener(() {
      if (_confirmFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(100.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _emailFocus.addListener(_onEmailFocusChange);
    _passwordFocus.addListener(_onPasswordFocusChange);
    _confirmFocus.addListener(_onConfirmFocusChange);

    _emailController.text = _formData['email'] ?? '';
    _passwordController.text = _formData['password'] ?? '';
    _confirmController.text = _formData['confirm_password'] ?? '';

    if (_formData['email'] != null && isValidEmail(_formData['email']!)) {
      setState(() {
        _checkedemail = true;
        _emailError = '';
      });
    }
    if (_formData['password'] != null && _formData['password']!.length >= 8) {
      setState(() {
        _checkedPassword = true;
        _passwordError = '';
      });
    }
    if (_formData['confirm_password'] != null && _formData['confirm_password'] == _formData['password'] && _formData['confirm_password']!.length >= 8) {
      setState(() {
        _checkedPasswordConfirmation = true;
        _passwordConfirmationError = '';
      });
    }

    if(_checkedemail && _checkedPassword && _checkedPasswordConfirmation && checkedValue) {
      setState(() {
        _allChecked = true;
      });
    } 
  }

    @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> emailExists(String value) async {
  final response = await ApiManager().checkEmail(value);
  if (response['status'] == 200) {
    return true;
  } else {
    return false;
  }
}

  bool isValidEmail(String value) {
    RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(value);
  }

void _onEmailFocusChange() async {
  if (!_emailFocus.hasFocus) {
    if (isValidEmail(_emailController.text) == true && await emailExists(_emailController.text) == true) {
      setState(() {
        _checkedemail = true;
        _emailError = '';
      });
      _formData['email'] = _emailController.text;
      // ignore: use_build_context_synchronously
      Provider.of<RegistrationData>(context, listen: false).updateFormData('email', _emailController.text);
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
          _formData['password'] = _passwordController.text;
          Provider.of<RegistrationData>(context, listen: false).updateFormData('password', _passwordController.text);
        });
      }
      checkFields();
    }
  }

  void _onConfirmFocusChange() {
    if (!_confirmFocus.hasFocus) {
      if(_confirmController.text.isNotEmpty){
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
            _formData['confirm_password'] = _confirmController.text;
          });
        }
            checkFields();
      } 

    }
  }

  void checkFieldsAndNavigate() {
    setState(() {
      _emailNotFilled = !_checkedemail;
      _passwordNotFilled = !_checkedPassword;
      _passwordConfirmationNotFilled = !_checkedPasswordConfirmation;
    });

    if (_emailNotFilled || _passwordNotFilled || _passwordConfirmationNotFilled || !checkedValue) {
      return;
    } else {
      setState(() => _allChecked = true);
      Navigator.pushNamed(context, '/saveRegistration');
    }
  }


  void checkFields() {
    if(!_checkedemail || !_checkedPassword || !_checkedPasswordConfirmation || !checkedValue) {
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
                      CustomInputField(
                        labelText: 'email',
                        hintText: '',
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        controller: _emailController,
                        focusNode: _emailFocus,
                        checked: _checkedemail,
                        hasError: (_emailError.isNotEmpty) ? _emailError.isNotEmpty : (_emailNotFilled && _emailError.isEmpty && !_checkedemail) ? true : false,
                        errorMessage: _emailError.isNotEmpty ? _emailError : _emailNotFilled ? AppLocalizations.of(context).translate("required_field") : null,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('.*'))],
                        onSubmitted: (String value) {
                          _passwordFocus.requestFocus();
                        },
                      ),
                      CustomInputField(
                        labelText: 'password',
                        hintText: '',
                        isPassword: true,
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        checked: _checkedPassword,
                        hasError: _passwordError.isNotEmpty || (_passwordNotFilled && _passwordError.isEmpty && !_checkedPassword) ? true : false,
                        errorMessage: _passwordError.isNotEmpty ? _passwordError : _passwordNotFilled ? AppLocalizations.of(context).translate("required_field") : null,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('.*'))],
                        onSubmitted: (String value) {
                          _confirmFocus.requestFocus();
                        },
                      ),
                      CustomInputField(
                        labelText: 'confirm_password',
                        hintText: '',
                        isPassword: true,
                        keyboardType: TextInputType.text,
                        controller: _confirmController,
                        focusNode: _confirmFocus,
                        checked: _checkedPasswordConfirmation,
                        hasError: _passwordConfirmationError.isNotEmpty || (_passwordConfirmationNotFilled && _passwordConfirmationError.isEmpty && !_checkedPasswordConfirmation) ? true : false,
                        errorMessage: _passwordConfirmationError.isNotEmpty ? AppLocalizations.of(context).translate("passwords_do_not_match") : _passwordConfirmationNotFilled ? AppLocalizations.of(context).translate("required_field") : null,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('.*'))],
                        onSubmitted: (String value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Theme(
                      data: Theme.of(context).copyWith(
                            checkboxTheme: CheckboxThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                  color: states.contains(MaterialState.selected)
                                      ? BrandColors.secondaryNight
                                      : BrandColors.secondaryNight, // Change this to your desired unselected border color
                                ),
                              ),
                              checkColor: MaterialStateProperty.all(BrandColors.white),
                            ),
                        unselectedWidgetColor: BrandColors.secondaryNight, // Change this to your desired color
                        ), 
                      child:
                      CheckboxListTile(
                        title: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: BrandColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Proxima-Soft'
                              ),
                            children: <TextSpan>[
                              TextSpan(text:  AppLocalizations.of(context).translate( 'i_agree_to_the')),
                              TextSpan(
                                text: AppLocalizations.of(context).translate('privacy_policy_and_terms_of_use'),
                                style: const TextStyle(fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/privacy');
                                  },
                              ),
                            ],
                          ),
                        ),
                        value: checkedValue,
                        onChanged: (newValue) {
                          setState(() {
                            _formData['privacy'] = newValue.toString();
                            Provider.of<RegistrationData>(context, listen: false).updateFormData('privacy', newValue.toString() );
                            checkedValue = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                        activeColor: BrandColors.secondaryNight,
                      ),
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
                                  Navigator.pushNamed(context, '/aedRegistration');
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
                                      Navigator.pushNamed(context, '/saveRegistration');
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
                child: const DotProgressBar(totalSteps: 4, currentStep: 3),
              ),
            ),
          ),
          ], 
          ),
      ),
    );
  }
}
