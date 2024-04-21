import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/input_field.dart';
import 'package:theapp/components/header_logo.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/main.dart';

GlobalVariables globalVariables = GlobalVariables();



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final ScrollController _scrollController = ScrollController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  String _emailError = '';
  String _passwordError = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
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
    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(50.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });


  }

  void checkLogin() {
  if (_emailController.text.isEmpty && _passwordController.text.isNotEmpty) {
        setState(() {
          _emailError = 'required_field';
        });
  } else if (_passwordController.text.isEmpty && _emailController.text.isNotEmpty) {
        setState(() {
          _passwordError = 'required_field';
        });
  }else if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
        setState(() {
          _emailError = 'required_field';
          _passwordError = 'required_field';
        });
  } else {
    setState(
      () {
        _emailError = '';
        _passwordError = '';
      },
    );
    ApiManager apiManager = ApiManager();
    apiManager.loginUser({
      'email': _emailController.text,
      'password': _passwordController.text,
    }).then((result) {
      if (result['status'] == 200) {
        GlobalVariables.loggedin = true;
        Navigator.pushReplacementNamed(context, '/home');
      } else if(result['message'] == 'Email not found') {
        setState(() {
          _emailError = 'email_not_found';
        });
      }else if(result['message'] == 'Password is incorrect') {
        setState(() {
          _passwordError = 'password_incorrect';
        });
      }
    }).catchError((error) {
      if(_emailController.text.isEmpty && _passwordController.text.isNotEmpty){
        setState(() {
          _emailError = 'required_field';
        });
      }
      if(_passwordController.text.isEmpty && _emailController.text.isNotEmpty){
        setState(() {
          _passwordError = 'required_field';
        });
      }
      if(_emailController.text.isEmpty && _passwordController.text.isEmpty){
        setState(() {
          _emailError = 'required_field';
          _passwordError = 'required_field';
        });
      }

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
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
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
                                textCapitalization: TextCapitalization.words,
                                onSubmitted: (String value) {
                                  _passwordFocus.requestFocus();
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
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomInputField(
                                labelText: 'password',
                                hintText: '',
                                isPassword: true,
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                focusNode: _passwordFocus,
                                textCapitalization: TextCapitalization.words,
                                inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
                                onSubmitted: (String value) {
                                },
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 32),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/forgot-password');
                                  },
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  ),
                                  child:  Text(AppLocalizations.of(context).translate("forgot_password"), style: const TextStyle(color: BrandColors.gray, fontSize: 14, decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            ],
                          ),
                          if (_passwordError.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(right: 32, top: 10),
                              child: Text(
                                AppLocalizations.of(context).translate(_passwordError),
                                style: const TextStyle(color: BrandColors.warning, fontSize: 14),
                              ),
                            ),
                        ],
                      ),
                      Container(height: 60,
                      margin: const EdgeInsets.only(left: 32, right: 32),
                      child: ElevatedButtonBlue(
                        child: 
                        const Text("Login", style: TextStyle(color: BrandColors.white, fontSize: 16)),
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