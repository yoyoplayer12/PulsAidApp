import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/classes/apimanager.dart';
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

    Future<bool> emailExists(String value) async {
    final response = await ApiManager().checkEmail(value);
    if (response['status'] != 200) {
      return true;
    } else {
      return false;
    }
  }

      
      void sendMail() async {
        if (_emailController.text.isEmpty == true || await emailExists(_emailController.text) == false){
          setState(() {
            if(_emailController.text.isEmpty){
            _emailError = 'required_field';
            } else {
              _emailError = 'email_not_found';
            }
            return;
          });
        } else {
          setState(
            () {
              _emailError = '';
            },
          );
      
          // Generate a random code
          var rng = Random();
          var code = rng.nextInt(900000) + 100000; // generates a 6 digit random number
          await dotenv.load();
          final smtpServer = gmail("evelienvanophalvens@gmail.com", dotenv.env['GMAIL']!);


              
          // Define the message
          final message = Message()
            ..from = const Address("evelienvanophalvens@gmail.com", 'Pulsaid')
            ..recipients.add(_emailController.text)
            ..subject = 'Password Reset Code'
            ..html = """
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
            await send(message, smtpServer);
            await ApiManager().saveRecoveryCode(code, _emailController.text);

            Future.microtask(() {
              Navigator.of(context).pushNamed('/code');
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
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
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
                          sendMail();
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