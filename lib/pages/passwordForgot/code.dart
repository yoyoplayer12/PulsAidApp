import 'dart:async';
import 'dart:math';import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/input_field.dart';
import 'package:theapp/components/header_logo.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/app_localizations.dart';


class Code extends StatefulWidget {
  final String email;
  const Code({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
    final ScrollController _scrollController = ScrollController();
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _codeFocus = FocusNode();
  String _codeError = '';

  @override
  void dispose() {
    _codeController.dispose();
    _codeFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _codeFocus.addListener(() {
      if (_codeFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });


  }
void checkCode() async {
  try {
    var response = await ApiManager().checkRecoveryCode(_codeController.text, widget.email);
    if (response['status'] == 200) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/resetPassword', arguments: widget.email);
    } else {
      setState(() {
        _codeError = 'invalid_code';
      });
    }
  } catch (e) {
    print('Failed to check recovery code: $e');
    // You can handle the error here, for example, by showing a message to the user
  }
}

  void startTimer() {
  Timer.periodic(const Duration(minutes: 2), (Timer t) async {
    var rng = Random();
          var code = rng.nextInt(900000) + 100000; // generates a 6 digit random number
          await dotenv.load();
          final smtpServer = gmail("evelienvanophalvens@gmail.com", dotenv.env['GMAIL']!);
          
          // ignore: use_build_context_synchronously
          Locale locale = AppLocalizations.of(context).locale;
          String languageCode = locale.languageCode;

          String getEmailContent(String languageCode, int code) {
            switch (languageCode) {
              case 'en':
                return """
                  <style>
                    @import url("https://use.typekit.net/jvl1kge.css");
                    body {
                      font-family: "your-font-name", sans-serif;
                    }
                  </style>
                  <div style="text-align: center; margin-bottom: 32px;">
                    <img class='logo' src='https://res.cloudinary.com/duzf7rh6t/image/upload/v1715262549/logo_qlysjc.png' style='width: 158px; height: 106px;'>
                  </div>
                  <table width="100%" height="100%" style="background-color: #E1E4F1; max-width: 600px; margin: 0 auto; border-radius: 10px; padding: 32px;">
                    <tr>
                      <td align="center" valign="middle" style="padding-top: 32px; padding-bottom: 32px;">
                        <h1 style='margin-top: 20px;'>Password Reset Code</h1>
                        <p>Trouble to login in your pulsaid account? If this isn't true just ignore the mail and nothing will happen<p>
                        <p>Your password reset code is: <strong>$code<strong></p>
                      </td>
                    </tr>
                  </table>
                """;
              case 'nl':
                return """
                                    <style>
                    @import url("https://use.typekit.net/jvl1kge.css");
                    body {
                      font-family: "your-font-name", sans-serif;
                    }
                  </style>
                  <div style="text-align: center; margin-bottom: 32px;">
                    <img class='logo' src='https://res.cloudinary.com/duzf7rh6t/image/upload/v1715262549/logo_qlysjc.png' style='width: 158px; height: 106px;'>
                  </div>
                  <table width="100%" height="100%" style="background-color: #E1E4F1; max-width: 600px; margin: 0 auto; border-radius: 10px; padding: 32px;">
                    <tr>
                      <td align="center" valign="middle" style="padding-top: 32px; padding-bottom: 32px;">
                        <h1 style='margin-top: 20px;'>Wachtwoord Reset Code</h1>
                        <p>Problemen bij het inloggen op je pulsaid account? Als dit niet klopt kan je deze mail negeren en gebeurd er niets.<p>
                        <p>Jouw wachtwoord reset code is: <strong>$code<strong></p>
                      </td>
                    </tr>
                  </table>
                """;
              default:
                return """
                  <style>
                    @import url("https://use.typekit.net/jvl1kge.css");
                    body {
                      font-family: "your-font-name", sans-serif;
                    }
                  </style>
                  <div style="text-align: center; margin-bottom: 32px;">
                    <img class='logo' src='https://res.cloudinary.com/duzf7rh6t/image/upload/v1715262549/logo_qlysjc.png' style='width: 158px; height: 106px;'>
                  </div>
                  <table width="100%" height="100%" style="background-color: #E1E4F1; max-width: 600px; margin: 0 auto; border-radius: 10px; padding: 32px;">
                    <tr>
                      <td align="center" valign="middle" style="padding-top: 32px; padding-bottom: 32px;">
                        <h1 style='margin-top: 20px;'>Password Reset Code</h1>
                        <p>Trouble to login in your pulsaid account? If this isn't true just ignore the mail and nothing will happen<p>
                        <p>Your password reset code is: <strong>$code<strong></p>
                      </td>
                    </tr>
                  </table>
                """;
            }
          }

          String getEmailSubject(String languageCode) {
            switch (languageCode) {
              case 'en':
                return "Password Reset Code";
              case 'nl':
                return "Wachtwoord Reset Code";
              // Add more cases for other languages
              default:
                return "Password Reset Code";
            }
          }
          
              
          // Define the message
          final message2 = Message()
            ..from = const Address("evelienvanophalvens@gmail.com", 'Pulsaid')
            ..recipients.add(widget.email)
            ..subject = getEmailSubject(languageCode)
            ..html = getEmailContent(languageCode, code);

            await send(message2, smtpServer);
            await ApiManager().saveRecoveryCode(code, widget.email);
  });
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
                                  AppLocalizations.of(context).translate("enter_code_info"), 
                                style: const TextStyle(color: BrandColors.gray, fontSize: 16), 
                                )
                              ),
                              const SizedBox(height: 24),
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                CustomInputField(
                                  labelText: 'code',
                                  hintText: '',
                                  isPassword: false,
                                  keyboardType: TextInputType.text,
                                  controller: _codeController,
                                  focusNode: _codeFocus,
                                  inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
                                  textCapitalization: TextCapitalization.none,
                                  onSubmitted: (String value) {
                                  },
                                ),
                                  if (_codeError.isNotEmpty)
                                Container(
                                  margin: const EdgeInsets.only(right: 32, top: 10),
                                  child: Text(
                                    AppLocalizations.of(context).translate(_codeError),
                                    style: const TextStyle(color: BrandColors.warning, fontSize: 14),
                                  ),
                                ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(height: 60,
                      margin: const EdgeInsets.only(left: 32, right: 32, top: 16),
                      child: ElevatedButtonBlue(
                        child: 
                        Text(AppLocalizations.of(context).translate('send'), style: const TextStyle(color: BrandColors.white, fontSize: 16)),
                        onPressed: () {
                          checkCode();
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