import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/classes/registration_data.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/header_logo.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/input_field.dart';

Map<String, String> _formData = {
  'password': '',
  'confirm_password': '',
};


class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();
  String _passwordError = '';
  String _passwordConfirmationError = '';

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _checkedPassword = false;
  bool _checkedPasswordConfirmation = false;
  bool _passwordNotFilled = false;
  bool _passwordConfirmationNotFilled = false;

  @override
  void initState() {
    super.initState();
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
    _passwordFocus.addListener(_onPasswordFocusChange);
    _confirmFocus.addListener(_onConfirmFocusChange);

    _passwordController.text = _formData['password'] ?? '';
    _confirmController.text = _formData['confirm_password'] ?? '';


    if (_formData['password'] != null && _formData['password']!.length >= 8) {
      setState(() {
        _checkedPassword = true;
        _passwordError = '';
      });
    }
    if (_formData['confirm_password'] != null && _formData['confirm_password'] == _formData['password'] && _formData['confirm_password'] != '') {
      setState(() {
        _checkedPasswordConfirmation = true;
        _passwordConfirmationError = '';
      });
    }

    if( _checkedPassword && _checkedPasswordConfirmation) {
      setState(() {
      });
    } 
  }

    @override
  void dispose() {
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    _scrollController.dispose();
    super.dispose();
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

void checkFieldsAndNavigate() {
  setState(() {
    _passwordNotFilled = !_checkedPassword;
    _passwordConfirmationNotFilled = !_checkedPasswordConfirmation;
  });

  if ( _passwordNotFilled || _passwordConfirmationNotFilled) {
    return;
  } else {
    ApiManager().passwordChange(_formData["password"]!, widget.email);
    Navigator.pushNamed(context, '/login');
  }
}


void checkFields() {
  if( !_checkedPassword || !_checkedPasswordConfirmation) {
    setState(() {
    });
  } else {
    setState(() {
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
                const headerLogo(),
                  Column(
                    children: [
                       const SizedBox(height: 32),
                        Text(
                          AppLocalizations.of(context).translate("set_password"), 
                          style: const TextStyle(color: BrandColors.gray, fontSize: 18, fontWeight: FontWeight.w500), 
                        ),
                        CustomInputField(
                          labelText: 'password',
                          hintText: '',
                          isPassword: true,
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          checked: _checkedPassword,
                          hasError: _passwordError.isNotEmpty || (_passwordNotFilled && _passwordError.isEmpty),
                          errorMessage: _passwordError.isNotEmpty? _passwordError : (_passwordNotFilled && _passwordError.isEmpty)? AppLocalizations.of(context).translate("required_field"): null,
                          inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
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
                          hasError: _passwordConfirmationError.isNotEmpty || (_passwordConfirmationNotFilled && _passwordConfirmationError.isEmpty),
                          errorMessage: _passwordConfirmationError.isNotEmpty? _passwordConfirmationError : (_passwordConfirmationNotFilled && _passwordConfirmationError.isEmpty)? AppLocalizations.of(context).translate("required_field"): null,
                          inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
                          onSubmitted: (String value) {  },
                        ),
                    ],
                  ),
                   Container(height: 60,
                      margin: const EdgeInsets.only(left: 32, right: 32, top: 16),
                      child: ElevatedButtonBlue(
                        child: 
                        Text(AppLocalizations.of(context).translate('save'), style: const TextStyle(color: BrandColors.white, fontSize: 16)),
                        onPressed: () {
                          checkFieldsAndNavigate();
                        },
                      ),
                      ),
              ],
            ),
            ),
          ], 
          ),
      ),
    );
  }
}
