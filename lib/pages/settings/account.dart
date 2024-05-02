
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_dark_blue.dart';
import 'package:theapp/components/input_field_account.dart';
import 'package:theapp/components/input_formatters/date_input_formatter.dart';
import 'package:theapp/components/navbar.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountSettings> {
  String firstname = '';
  String lastname = '';
  String dob = '';
  String email = '';
  String password = '';
  bool _firstnameNotFilled = false;
  bool _lastnameNotFilled = false;
  bool _dobNotFilled = false;
  bool _emailNotFilled = false;
  bool _passwordNotFilled = false;
  String _dobError = '';
  String _emailError = '';
  String _passwordError = '';

  final TextEditingController _fistnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  
  //logincheck
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  bool isValidEmail(String value) {
  RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regex.hasMatch(value);
}

  void save() {

  setState(() {
    _firstnameNotFilled = _lastnameNotFilled = _dobNotFilled = _emailNotFilled = _passwordNotFilled = false;
    _dobError = _emailError = _passwordError = '';
  });

  // Check if the fields are filled
  if (_fistnameController.text.isEmpty) {
    setState(() {
      _firstnameNotFilled = true;
    });
  }
  if (_lastnameController.text.isEmpty) {
    setState(() {
      _lastnameNotFilled = true;
    });
  }
  if (_dobController.text.isEmpty) {
    setState(() {
      _dobNotFilled = true;
    });
  }
  if (_emailController.text.isEmpty) {
    setState(() {
      _emailNotFilled = true;
    });
  }

  if (!(_firstnameNotFilled || _lastnameNotFilled || _dobNotFilled || _emailNotFilled)) {


 var parts = _dobController.text.split('/');
  if (parts.length == 3) {
    var day = int.tryParse(parts[0]);
    var month = int.tryParse(parts[1]);
    var year = int.tryParse(parts[2]);

    // Validate the day
    if (day == null || day < 1 || day > 31) {
      setState(() {
        _dobError = 'invalid_date';
      });
    }

    // Validate the month
    if (month == null || month < 1 || month > 12) {
      setState(() {
        _dobError = 'invalid_date';
      });
      return;
    }

    // Validate the age
    var now = DateTime.now();

    var birthDate = DateTime(year!, month, day!);

    var age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    // Check if the year is null, less than 70 years ago, or more than 18 years ago
    if (age < 18 || age > 70) {
      setState(() {
        _dobError = 'invalid_age';  // Set the error message
      });
      return;
    }
  // Check the email
  if (!isValidEmail(_emailController.text)) {
    _emailError = 'invalid_email';
  }

  if(_passwordController.text.isNotEmpty){
  //check if password has more the 8 characters
  if (_passwordController.text.length < 8) {
    _passwordError = 'password_too_short';
    return;
  }
  }

    if (_dobError.isEmpty && _emailError.isEmpty && _passwordError.isEmpty) {


  // If everything is fine, save the data
  ApiManager().saveUserInfo(
    _fistnameController.text,
    _lastnameController.text,
    _emailController.text,
    _dobController.text,
    _passwordController.text,
  ).then((result) {
    if (result['status'] == 200) {
      Navigator.pop(context);
    }
  });
  
  }
  }
  }
}

Future<void> getUserInfo() async {
  final userInfo = await ApiManager().userInfo();
  setState(() {
    firstname = userInfo['user']['firstname'];
    lastname = userInfo['user']['lastname'];
    DateTime birth = DateFormat('yyyy-MM-ddTHH:mm:ss.sssZ').parse(userInfo['user']['dob']);
    dob = DateFormat('dd-MM-yyyy').format(birth).replaceAll("-", "/");
    email = userInfo['user']['email'];
    password = userInfo['user']['password'];
    _fistnameController.text = firstname;
    _lastnameController.text = lastname;
    _dobController.text = dob;
    _emailController.text = email;
  });
}

void delete() {
  ApiManager().deleteAccount().then((result) {
    if (result['status'] == 200) {
      Navigator.pushNamed(context, '/login');
    }
  });
}

//main content
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
                  "Account",
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
                      save();
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
              margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
              child: Column(children: [
                CustomTextField(
                  controller: _fistnameController,
                  original: firstname,
                  label: 'first_name',
                  hint: 'first_name',
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                  errorText: _firstnameNotFilled ? 'required_field' : "",
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _lastnameController,
                  original: lastname,
                  label: 'last_name',
                  hint: 'last_name',
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                  errorText: _lastnameNotFilled ? 'required_field' : "",
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _dobController,
                  original: dob,
                  label: 'date_of_birth',
                  hint: 'date_of_birth',
                  inputFormatters: [ DateInputFormatter() ],
                  errorText: _dobNotFilled ? 'required_field' :  _dobError != '' ? _dobError : '',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  original: email,
                  inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
                  label: 'email',
                  hint: 'email',
                  errorText: _emailNotFilled ? 'required_field' :  _emailError != '' ? _emailError : '',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
                  obscureText: true,
                  original: password,
                  controller: _passwordController,
                  label: 'password',
                  hint: 'password',
                  errorText: _passwordNotFilled ? 'required_field' : _passwordError != '' ? _passwordError : '',
                ),
              ],)
            ),
          ],
        ),
         Positioned(
              bottom: 64,
              child: Container(
                width: MediaQuery.of(context).size.width - 64,
                margin: const EdgeInsets.only(right: 32, left: 32),
                child: ElevatedButtonDarkBlue(
                  icon: Icons.keyboard_arrow_right_rounded,
                  background: BrandColors.white,
                  foreground: BrandColors.secondaryExtraDark,
                  onPressed: () {
                    Navigator.pushNamed(context, '/changeType');
                  },
                   child: Text(
                    AppLocalizations.of(context).translate("change_account_type"),
                  ),
                ),
              ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: TextButton(
            onPressed: () =>
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => Theme(
                  data: Theme.of(context).copyWith(dialogBackgroundColor: BrandColors.white ), // Change to your desired color
                  child: AlertDialog(
                    surfaceTintColor: BrandColors.white,
                    title: Text(AppLocalizations.of(context).translate('delete_account')),
                    content: Text(AppLocalizations.of(context).translate('are_you_sure_you_want_to_delete_your_account')),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: Text(AppLocalizations.of(context).translate('cancel'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: BrandColors.gray)),
                      ),
                      TextButton(
                        onPressed: delete,
                        child: Text(AppLocalizations.of(context).translate('delete_account'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: BrandColors.extraDarkCta)),
                      )
                    ],
                  ),
                ),
              ),
              child: Text(
              AppLocalizations.of(context).translate('delete_account'), 
              style: const TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.w300, 
                color: BrandColors.gray,
                decoration: TextDecoration.underline
                )
              ),
          ),
        ),
      ],
    ),
    );
}
}