import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/input_field.dart';

Map<String, dynamic> _formData = {
  'contact': {
        'phone': '',
        'email': '',
        'instagram': '',
        'facebook': '',
  },
  'role': ''
};
class UploadContact extends StatefulWidget {
  final String role;
  const UploadContact({super.key, required this.role});

  @override
  // ignore: library_private_types_in_public_api
  _UploadContact createState() => _UploadContact();
}

class _UploadContact extends State<UploadContact> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _instagramFocus = FocusNode();
  final FocusNode _facebookFocus = FocusNode();

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
    _formData['role'] = widget.role;
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
        _formData['contact']['email'] = _emailController.text;        
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
                AppBar(
                centerTitle: true,
                title:  Text(
                  AppLocalizations.of(context).translate('add_contact_info'),
                  style: const TextStyle(
                    color: BrandColors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                backgroundColor: Colors.transparent, // make the AppBar background transparent
                elevation: 0, // remove shadow
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 30.0), // adjust the value as needed
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 32, color: BrandColors.grey, semanticLabel: 'Exit'), // replace with your desired icon
                      onPressed: () {
                        // handle the icon tap here
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ]
              ),
               Container(
                        margin: const EdgeInsets.only(
                          top: 16,
                          left: 32,
                          right: 32,
                        ),
                        child: Text(
                          AppLocalizations.of(context).translate('upload_contact_info_info'),
                          style: const TextStyle(
                            color: BrandColors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
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
                                Navigator.pushNamed(context, '/changeType');
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
                                        Navigator.pushNamed(context, '/saveContactInfo', arguments: _formData);
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
            ],
          ),
        ),
      ),
    );
  }
}
