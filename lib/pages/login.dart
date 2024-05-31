import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/input_field.dart';
import 'package:theapp/components/header_logo.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/app_localizations.dart';

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
        _scrollController.animateTo(0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
      }
    });
    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(50.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
      }
    });
  }

  void checkLogin() {
    if (_emailController.text.isEmpty && _passwordController.text.isNotEmpty) {
      setState(() {
        _emailError = 'required_field';
      });
    } else if (_passwordController.text.isEmpty &&
        _emailController.text.isNotEmpty) {
      setState(() {
        _passwordError = 'required_field';
      });
    } else if (_emailController.text.isEmpty &&
        _passwordController.text.isEmpty) {
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
      }).then((result) async {
        if (result['status'] == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('loggedin', true);
          await prefs.setString('user', result['id']);
          OneSignal.login(result['id']);
          await prefs.setString('role', result['role']);
          await prefs.setString('language', result['language'] ?? 'en');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(context, '/home');
          });
        } else if (result['message'] == 'Email not found') {
          setState(() {
            _emailError = 'email_not_found';
          });
        } else if (result['message'] == 'Password is incorrect') {
          setState(() {
            _passwordError = 'password_incorrect';
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
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const headerLogo(),
                  Column(
                    children: [
                      CustomInputField(
                        labelText: 'email',
                        hintText: '',
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        controller: _emailController,
                        focusNode: _emailFocus,
                        hasError: _emailError.isNotEmpty,
                        errorMessage: _emailError.isNotEmpty
                            ? AppLocalizations.of(context)
                                .translate(_emailError)
                            : null,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('.*'))
                        ],
                        textCapitalization: TextCapitalization.none,
                        onSubmitted: (String value) {
                          _passwordFocus.requestFocus();
                        },
                      ),
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
                            hasError: _passwordError.isNotEmpty,
                            errorMessage: _passwordError.isNotEmpty
                                ? AppLocalizations.of(context)
                                    .translate(_passwordError)
                                : null,
                            textCapitalization: TextCapitalization.none,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('.*'))
                            ],
                            onSubmitted: (String value) {},
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/forgot-password');
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("forgot_password"),
                                style: const TextStyle(
                                    color: BrandColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 32, right: 32),
                          child: Column(
                            children: [
                              ElevatedButtonBlue(
                                child: const Text("Login",
                                    style: TextStyle(
                                        color: BrandColors.white,
                                        fontSize: 16)),
                                onPressed: () {
                                  checkLogin();
                                },
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () {
                                    Navigator.pushNamed(context, '/role');
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate("register"),
                                  style: const TextStyle(
                                      color: BrandColors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                ),
                              ),
                              ),
                            ]
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
