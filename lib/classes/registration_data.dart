import 'package:flutter/foundation.dart';

class RegistrationData extends ChangeNotifier {
  final Map<String, String> _formData = {
    'language': '',
    'role': '',
    'firstname': '',
    'lastname': '',
    'dob': '',
    'email': '',
    'password': '',
    'certification_type': '',
    'certification_number': '',
    'certification_begindate': '',
    'certification_enddate': '',
    'certification': '',
  };

  Map<String, String> get formData => _formData;

  void updateFormData(String key, String value) {
    _formData[key] = value;
    notifyListeners();
  }
}