
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:theapp/classes/registration_data.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/header_registration.dart';
import 'package:theapp/components/input_field.dart';
import 'package:theapp/components/input_formatters/date_input_formatter.dart';

Map<String, String> _formData = {
  'firstname': '',
  'lastname': '',
  'dob': '',
};

class EarRegistrationPage extends StatefulWidget {
  const EarRegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EarRegistrationPageState createState() => _EarRegistrationPageState();
}

class _EarRegistrationPageState extends State<EarRegistrationPage> {

  final ScrollController _scrollController = ScrollController();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  String _dateError = "";
  bool _checkedFirstname = false;
  bool _checkedLastname = false;
  bool _checkedDate = false;
  bool _dateNotFilled = false;
  bool _firstnameNotFilled = false;
  bool _lastNameNotFilled = false;
  bool _allChecked = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  

  @override
  void dispose() {
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _dobFocus.dispose();
    _scrollController.dispose();
    super.dispose();
    _firstNameFocus.removeListener(_onFirstNameFocusChange);
    _firstNameFocus.dispose();
  }


  @override
  void initState() {
    super.initState();
    _firstNameFocus.addListener(() {
      if (_firstNameFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _lastNameFocus.addListener(() {
      if (_lastNameFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(50.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _dobFocus.addListener(() {
      if (_dobFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(100.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });

    _firstNameFocus.addListener(_onFirstNameFocusChange);
    _lastNameFocus.addListener(_onLastNameFocusChange);

    _firstNameController.text = _formData['firstname'] ?? '';
    _lastNameController.text = _formData['lastname'] ?? '';
    _dobController.text = _formData['dob'] ?? '';

    if(_formData['firstname'] != null && _formData['firstname'] != '') {
      setState(() {
        _checkedFirstname = true;
      });
    }
    if(_formData['lastname'] != null && _formData['lastname'] != '') {
      setState(() {
        _checkedLastname = true;
      });
    }
    if(_formData['dob'] != null && _formData['dob'] != '') {
      setState(() {
        _checkedDate = true;
      });
    }

    if(_checkedDate && _checkedFirstname && _checkedLastname) {
      setState(() {
        _allChecked = true;
      });
    }
  }


  void onButtonClick() {
  var parts = _dobController.text.split('/');
  if (parts.length == 3) {
    var day = int.tryParse(parts[0]);
    var month = int.tryParse(parts[1]);
    var year = int.tryParse(parts[2]);

    // Validate the day
    if (day == null || day < 1 || day > 31) {
      setState(() {
        _dateError = 'invalid_date';
        _checkedDate = false;
        _dateNotFilled = false;
      });
      return;
    }

    // Validate the month
    if (month == null || month < 1 || month > 12) {
      setState(() {
        _dateError = 'invalid_date';
        _checkedDate = false;
        _dateNotFilled = false;
      });
      return;
    }

    // Validate the age
    var now = DateTime.now();

    var birthDate = DateTime(year!, month, day);

    var age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    // Check if the year is null, less than 70 years ago, or more than 18 years ago
    if (age < 18 || age > 70) {
      setState(() {
        _dateError = 'invalid_age';  // Set the error message
        _checkedDate = false;
        _dateNotFilled = false;
      });
      return;
    }

    // If the date is valid, clear the error message
    setState(() {
      _dateError = "";
      _checkedDate = true;
      _formData['dob'] = _dobController.text;
      Provider.of<RegistrationData>(context, listen: false).updateFormData('dob', _dobController.text);
    });
  } else {
    setState(() {
      _dateError = 'invalid_date';
      _checkedDate = false;
      _dateNotFilled = false;
    });
  }
  checkFields();
}

  void checkFieldsAndNavigate() {
    // Validate the fields
    _onFirstNameFocusChange();
    _onLastNameFocusChange();
    onButtonClick();

    setState(() {
      _dateNotFilled = !_checkedDate;
      _firstnameNotFilled = !_checkedFirstname;
      _lastNameNotFilled = !_checkedLastname;
    });

    if (_dateNotFilled || _firstnameNotFilled || _lastNameNotFilled) {
      return;
    } else {
      setState(() => _allChecked = true);
      Navigator.pushNamed(context, '/ehboRegistration2');
    }
  }

void checkFields() {
  if(!_checkedDate || !_checkedFirstname || !_checkedLastname) {
    setState(() {
      _allChecked = false;
    });
  } else {
    setState(() {
      _allChecked = true;
    });
  }
}

void _onFirstNameFocusChange() {
  if (!_firstNameFocus.hasFocus) {
    if (_firstNameController.text.trim().isEmpty) {
      setState(() {
        _checkedFirstname = false;
      });
    } else {
      setState(() {
        _firstnameNotFilled = false;
        _checkedFirstname = true;
      });
      _formData['firstname'] = _firstNameController.text;
      Provider.of<RegistrationData>(context, listen: false).updateFormData('firstname', _firstNameController.text);
    }
    checkFields();
  }
}

void _onLastNameFocusChange() {
  if (!_lastNameFocus.hasFocus) {
    if (_lastNameController.text.trim().isEmpty) {
      setState(() {
        _checkedLastname = false;
      });
    } else {
      setState(() {
        _lastNameNotFilled = false;
        _checkedLastname = true;
      });
      _formData['lastname'] = _lastNameController.text;
      Provider.of<RegistrationData>(context, listen: false).updateFormData('lastname', _lastNameController.text);
    }
    checkFields();
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
              const HeaderImageWithText(
                  imageAsset: 'assets/images/background_header_login.png',
                  title: 'registration',
                  subtitle: 'personal_information',
                ),
                Column(
                    children: [
                      CustomInputField(
                        labelText: 'first_name',
                        hintText: '',
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        controller: _firstNameController,
                        focusNode: _firstNameFocus,
                        checked: _checkedFirstname,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                        textCapitalization: TextCapitalization.words,
                        onSubmitted: (String value) {
                          _lastNameFocus.requestFocus();
                        },
                        hasError: _firstnameNotFilled? true : false,
                        errorMessage: AppLocalizations.of(context).translate("required_field"),
                      ),
                      CustomInputField(
                        labelText: 'last_name',
                        hintText: '',
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        controller: _lastNameController,
                        focusNode: _lastNameFocus,
                        hasError: _lastNameNotFilled,
                        errorMessage: AppLocalizations.of(context).translate("required_field"),
                        textCapitalization: TextCapitalization.words,
                        checked: _checkedLastname,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                        onSubmitted: (String value) {
                          _dobFocus.requestFocus();
                                },
                      ),            
                      CustomInputField(
                        labelText: 'date_of_birth',
                        hintText: 'dd/mm/yyyy',
                        isPassword: false,
                        keyboardType: TextInputType.datetime,
                        controller: _dobController,
                        focusNode: _dobFocus,
                        hasError: _dateError.isNotEmpty,
                        errorMessage: AppLocalizations.of(context).translate(_dateError),
                        checked: _checkedDate,
                        onSubmitted: (String value) {
                          onButtonClick();  // Call the validation logic when the user submits the keyboard
                        },
                        inputFormatters: [ DateInputFormatter() ],
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
                                  Navigator.pushNamed(context, '/roleAed');
                                },
                                child: const Text(''),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: GestureDetector(
                              onTap: checkFieldsAndNavigate,
                              child: ElevatedButtonBlue(
                              onPressed: 
                                _allChecked
                                  ? () {
                                    Navigator.pushNamed(context, '/earRegistration2');
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
                            )
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
                child: const DotProgressBar(totalSteps: 4, currentStep: 2),
              ),
            ),
          ),
          ], 
          ),
      ),
    );
  }
}
