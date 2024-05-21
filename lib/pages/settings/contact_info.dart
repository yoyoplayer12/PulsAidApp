import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/Button_dark_blue.dart';
import 'package:theapp/components/navbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/input_field.dart';


class ContactInfo extends StatefulWidget {
  const ContactInfo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactInfo createState() => _ContactInfo();
}

class _ContactInfo extends State<ContactInfo> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _instagramFocus = FocusNode();
  final FocusNode _facebookFocus = FocusNode();

  final Map<String, dynamic> _formData = {
    'contact': {
      'phone': '',
      'email': '',
      'instagram': '',
      'facebook': '',
    },
  };


  String _phoneNumberError = '';
  String _emailError = '';
  final String _instagramError = '';
  final String _facebookError = '';

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();

  final bool _checkedPhoneNumber = false;
  final bool _checkedEmail = false;
  final bool _checkedInstagram = false;
  final bool _checkedFacebook = false;
  bool _phoneNumberNotFilled = false;
  bool _emailNotFilled = false;
  bool _instagramNotFilled = false;
  bool _facebookNotFilled = false;
  bool _allChecked = false;

  @override
  void initState() {
    super.initState();
    _phoneNumberFocus.addListener(_onPhoneNumberFocusChange);
    _emailFocus.addListener(_onEmailFocusChange);
    _instagramFocus.addListener(_onInstagramFocusChange);
    _facebookFocus.addListener(_onFacebookFocusChange);


    _phoneNumberController.text = _formData['phone'] ?? '';
    _emailController.text = _formData['email'] ?? '';
    _instagramController.text = _formData['instagram'] ?? '';
    _facebookController.text = _formData['facebook'] ?? '';
    getUserInfo();

    }

  void getUserInfo() {
    ApiManager().userInfo().then((result) {
      if (result['status'] == 200) {
        setState(() {
          if (result['user']['contact'][0]['phone'] != null) {
            _phoneNumberController.text = result['user']['contact'][0]['phone'];
          }
          if (result['user']['contact'][0]['email'] != null) {
            _emailController.text = result['user']['contact'][0]['email'];
          }
          if (result['user']['contact'][0]['instagram'] != null) {
            _instagramController.text = result['user']['contact'][0]['instagram'];
          }
          if (result['user']['contact'][0]['facebook'] != null) {
            _facebookController.text = result['user']['contact'][0]['facebook'];
          }
        });
      }
    });
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
      setState(() {
         _allChecked = true;
        _phoneNumberError = '';
        _formData['contact']['phone'] = _phoneNumberController.text;        
      });
    }
    }else{
      setState(() {
        _phoneNumberError = '';
        _formData['contact']['phone'] = _phoneNumberController.text;        
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
        setState(() {
           _allChecked = true;
          _formData['contact']['email'] = _emailController.text;
          _emailError = '';
        });
      }
     }else{
      setState(() {
        _emailError = '';
        _formData['contact']['_email'] = _emailController.text;        
      });
    }
  }

  void _onInstagramFocusChange() {
    _formData['contact']['instagram'] = _instagramController.text;
    if( _instagramController.text.isNotEmpty){
      setState(() {
        _allChecked = true;
      });
    }
  }

  void _onFacebookFocusChange() {
    _formData['contact']['facebook'] = _facebookController.text;
    if( _facebookController.text.isNotEmpty){
      setState(() {
        _allChecked = true;
      });
    } 
  }

  void checkFieldsAndNavigate() {
    setState(() {
      _phoneNumberNotFilled = _phoneNumberController.text.isEmpty || (_phoneNumberError.isNotEmpty && _phoneNumberController.text.isNotEmpty);
      _emailNotFilled = _emailController.text.isEmpty || (_emailError.isNotEmpty && _emailController.text.isNotEmpty);
      _instagramNotFilled = _instagramController.text.isEmpty;
      _facebookNotFilled = _facebookController.text.isEmpty;
    });
  
    if (_phoneNumberNotFilled && _emailNotFilled && _instagramNotFilled && _facebookNotFilled) {
      return;
    } else {
      setState(() => _allChecked = true);
    }
  }

  void saveContactInfo() {
    if(_allChecked == false){
      checkFieldsAndNavigate();
    }else{
    _formData['contact']['phone'] = _phoneNumberController.text;
    _formData['contact']['email'] = _emailController.text;
    _formData['contact']['instagram'] = _instagramController.text;
    _formData['contact']['facebook'] = _facebookController.text;

print(_formData['contact']);
    ApiManager().saveContactInfo(_formData['contact']).then((result) {
      if (result['status'] == 200) {
        Navigator.pushNamed(context, '/account');
      }
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: Container(
      margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
      decoration: BoxDecoration(
        color: BrandColors.offWhiteLight,
        borderRadius: BorderRadius.circular(30), // Adjust the value as needed
      ),
      child: const CustomNavBar(
        selectedIndex: 3,
      ),
    ),  
      body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            AppBar(
              centerTitle: false,
              title: Container(
                margin: const EdgeInsets.only(left: 16.0), // adjust the value as needed
                child: const Text(
                  "Contact info",
                  style: TextStyle(
                    color: BrandColors.grayMid,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent, // make the AppBar background transparent
              elevation: 0, // remove shadow
              automaticallyImplyLeading: false,
              actions: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 16.0), // adjust the value as needed
                  child: ElevatedButtonDarkBlue(
                    child: Text( AppLocalizations.of(context).translate('save'), style: const TextStyle(color: BrandColors.offWhiteLight)),
                    onPressed: () {
                      // handle the icon tap here
                      saveContactInfo();
                    },
                  ),
                ),
                 Container(
                  margin: const EdgeInsets.only(right: 16.0), // adjust the value as needed
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 32, color: BrandColors.grayMid, semanticLabel: 'Exit'), // replace with your desired icon
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ]
            ), 
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      ),
    ],
    ),
    );
  }
}
