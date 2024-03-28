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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

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
  }

    @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    _scrollController.dispose();
    super.dispose();
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
                        inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
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
                        focusNode: _confirmFocus, onSubmitted: (String value) {  },
                        inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
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
                              child: ElevatedButtonBlue(
                                onPressed: 
                                  _emailController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty &&
                                  _confirmController.text.isNotEmpty
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