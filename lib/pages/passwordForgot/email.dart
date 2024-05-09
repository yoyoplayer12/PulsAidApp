import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/input_field.dart';
import 'package:theapp/components/header_logo.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/app_localizations.dart';



class Email extends StatefulWidget {
  const Email({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
    final ScrollController _scrollController = ScrollController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  String _emailError = '';

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });


  }

  void checkLogin() {
  if (_emailController.text.isEmpty) {
        setState(() {
          _emailError = 'required_field';
        });
  } else {
    setState(
      () {
        _emailError = '';
      },
    );
  
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
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 32),
                              Text(
                                AppLocalizations.of(context).translate("set_password"), 
                               style: const TextStyle(color: BrandColors.gray, fontSize: 18, fontWeight: FontWeight.w500), 
                              ),
                              const SizedBox(height: 16),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 32),
                                child: Text(
                                  AppLocalizations.of(context).translate("enter_email_info"), 
                                style: const TextStyle(color: BrandColors.gray, fontSize: 16), 
                                )
                              ),
                              const SizedBox(height: 24),
                              CustomInputField(
                                labelText: 'email',
                                hintText: '',
                                isPassword: false,
                                keyboardType: TextInputType.text,
                                controller: _emailController,
                                focusNode: _emailFocus,
                                inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
                                textCapitalization: TextCapitalization.none,
                                onSubmitted: (String value) {
                                },
                              ),
                            ],
                          ),
                          if (_emailError.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(right: 32, top: 10),
                              child: Text(
                                AppLocalizations.of(context).translate(_emailError),
                                style: const TextStyle(color: BrandColors.warning, fontSize: 14),
                              ),
                            ),
                        ],
                      ),
                      Container(height: 60,
                      margin: const EdgeInsets.only(left: 32, right: 32, top: 16),
                      child: ElevatedButtonBlue(
                        child: 
                        Text(AppLocalizations.of(context).translate('send'), style: const TextStyle(color: BrandColors.white, fontSize: 16)),
                        onPressed: () {
                          checkLogin();
                        },
                        
                      ),
                      ),
              ],
            ),
              ],
            ),
          )], 
          ),
      ),
    );
  }
}