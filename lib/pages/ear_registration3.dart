import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:theapp/classes/registration_data.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/input_field.dart';

Map<String, String> _formData = {
  'phoneNumber': '',
  'email': '',
  'instagram': '',
  'facebook': '',
  'privacy': '',
};

class EarRegistration3Page extends StatefulWidget {
  const EarRegistration3Page({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AedRegistrationPage3State createState() => _AedRegistrationPage3State();
}

class _AedRegistrationPage3State extends State<EarRegistration3Page> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _instagramFocus = FocusNode();
  final FocusNode _facebookFocus = FocusNode();

  String _phoneNumberError = '';
  String _emailError = '';
  final String _instagramError = '';
  final String _facebookError = '';
  bool checkedValue = false;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();

  final bool _checkedPhoneNumber = false;
  final bool _checkedEmail = false;
  final bool _checkedInstagram = false;
  final bool _checkedFacebook = false;
  bool _allChecked = false;

  @override
  void initState() {
    super.initState();
    _phoneNumberFocus.addListener(_onPhoneNumberFocusChange);
    _emailFocus.addListener(_onEmailFocusChange);
    _instagramFocus.addListener(_onInstagramFocusChange);
    _facebookFocus.addListener(_onFacebookFocusChange);


    _phoneNumberController.text = _formData['phoneNumber'] ?? '';
    _emailController.text = _formData['email'] ?? '';
    _instagramController.text = _formData['instagramName'] ?? '';
    _facebookController.text = _formData['facebookName'] ?? '';
  }

  @override
  void dispose() {
    _phoneNumberFocus.dispose();
    _emailFocus.dispose();
    _instagramFocus.dispose();
    _facebookFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool isValidPhoneNumber(String value) {
    String pattern = r'^[0-9]{10,15}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
  
  bool isValidEmail(String value) {
    RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(value);
  }

  void _onPhoneNumberFocusChange() {
    String phoneNumber = _phoneNumberController.text;

    if(phoneNumber.isNotEmpty){
    if (!isValidPhoneNumber(phoneNumber)) {
      setState(() {
        _phoneNumberError = 'Please enter a valid phone number';
      });
    } else {
      if(checkedValue){
        setState(() {
          _allChecked = true;
          _phoneNumberError = '';
          _formData['phoneNumber'] = _phoneNumberController.text;        
          Provider.of<RegistrationData>(context, listen: false).updateContactData('phone', _phoneNumberController.text);        
        });
      }
    }
    }else{
      setState(() {
        _phoneNumberError = '';
        _formData['phoneNumber'] = _phoneNumberController.text;        
        Provider.of<RegistrationData>(context, listen: false).updateContactData('phone', _phoneNumberController.text);        
      });
    }
  }
  
  void _onEmailFocusChange() {
    String email = _emailController.text;

     if(email.isNotEmpty){
      if (!isValidEmail(email)) {
        setState(() {
          _emailError = 'Please enter a valid email address';
        });
      } else {
        if(checkedValue){

          setState(() {
            _allChecked = true;
            _formData['email'] = _emailController.text;
            Provider.of<RegistrationData>(context, listen: false).updateContactData('email', _emailController.text);        
            _emailError = '';
          });
        }
      }
     }else{
      setState(() {
        _emailError = '';
        _formData['_email'] = _emailController.text;        
        Provider.of<RegistrationData>(context, listen: false).updateContactData('email', _emailController.text);        
      });
    }
  }

  void _onInstagramFocusChange() {
    _formData['instagram'] = _instagramController.text;
    Provider.of<RegistrationData>(context, listen: false).updateContactData('instagram', _instagramController.text); 
    if( _instagramController.text.isNotEmpty && checkedValue){
      setState(() {
        _allChecked = true;
      });
    }
  }

  void _onFacebookFocusChange() {
    _formData['facebook'] = _facebookController.text;
    Provider.of<RegistrationData>(context, listen: false).updateContactData('facebook', _facebookController.text);   
    if( _facebookController.text.isNotEmpty && checkedValue){
      setState(() {
        _allChecked = true;
      });
    } 
  }

  void checkFieldsAndNavigate() {
    if (checkedValue && _phoneNumberController.text.isNotEmpty || checkedValue && _emailController.text.isNotEmpty || checkedValue && _instagramController.text.isNotEmpty|| checkedValue && _facebookController.text.isNotEmpty) {
      setState(() => _allChecked = true);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Text(
                    AppLocalizations.of(context).translate('registration'),
                    style: const TextStyle(
                      color: BrandColors.secondaryNight,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppLocalizations.of(context).translate('contact_info'),
                    style: const TextStyle(
                      color: BrandColors.blackExtraLight,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    ),
                    Column(
                      children: [
                        CustomInputField(
                          labelText: 'phone',
                          hintText: '',
                          isPassword: false,
                          keyboardType: TextInputType.phone,
                          controller: _phoneNumberController,
                          focusNode: _phoneNumberFocus,
                          checked: _checkedPhoneNumber,
                          hasError: _phoneNumberError.isNotEmpty,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onSubmitted: (String value) {
                            _emailFocus.requestFocus();
                          },
                        ),
                        // Voeg hier eventuele foutmeldingen voor telefoonnummer toe
                        CustomInputField(
                          labelText: 'email',
                          hintText: '',
                          isPassword: false,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          focusNode: _emailFocus,
                          checked: _checkedEmail,
                          hasError: _emailError.isNotEmpty,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('.*'))],
                          onSubmitted: (String value) {
                            _instagramFocus.requestFocus();
                          },
                        ),
                        // Voeg hier eventuele foutmeldingen voor e-mail toe
                        CustomInputField(
                          labelText: 'instagram',
                          hintText: '',
                          isPassword: false,
                          keyboardType: TextInputType.text,
                          controller: _instagramController,
                          focusNode: _instagramFocus,
                          checked: _checkedInstagram,
                          hasError: _instagramError.isNotEmpty,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('.*'))],
                          onSubmitted: (String value) {
                            _facebookFocus.requestFocus();
                          },
                        ),
                        // Voeg hier eventuele foutmeldingen voor Instagram-naam toe
                        CustomInputField(
                          labelText: 'facebook',
                          hintText: '',
                          isPassword: false,
                          keyboardType: TextInputType.text,
                          controller: _facebookController,
                          focusNode: _facebookFocus,
                          checked: _checkedFacebook,
                          hasError: _facebookError.isNotEmpty,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('.*'))],
                          onSubmitted: (String value) {},
                        ),
                        // Voeg hier eventuele foutmeldingen voor Facebook-naam toe
                      ],
                    ),
                     const SizedBox(height: 32,),
                  CheckboxListTile(
                    title: RichText(
                      text: TextSpan(
                         style: const TextStyle(
                            color: BrandColors.grayDark,
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
                        _formData['privacy'] = newValue! ? 'true' : 'false';
                        Provider.of<RegistrationData>(context, listen: false).updateFormData('privacy', newValue.toString() );
                        checkedValue = newValue;
                        if(newValue && _phoneNumberController.text.isNotEmpty || newValue && _emailController.text.isNotEmpty || newValue && _instagramController.text.isNotEmpty|| newValue && _facebookController.text.isNotEmpty){
                            _allChecked = true;
                        }else{
                          _allChecked = false;
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  )
                  ],
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.14,
                child: Container(
                  margin: const EdgeInsets.only(left: 32, right: 32),
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
                                Navigator.pushNamed(context, '/aedRegistration2');
                              },
                              child: const Text(''),
                            ),
                          ),
                          SizedBox(
                            width: 180,
                            child: GestureDetector(
                              onTap: checkFieldsAndNavigate,
                              child: ElevatedButtonBlue(
                                onPressed: _allChecked
                                    ? () {
                                        Navigator.pushNamed(context, '/saveRegistration');
                                      }
                                    : null,
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
      ),
    );
  }
}
