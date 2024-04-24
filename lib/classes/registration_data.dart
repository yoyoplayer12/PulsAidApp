import 'package:flutter/foundation.dart';

class RegistrationData extends ChangeNotifier {
  final Map<String, dynamic> _formData = {
    'language': '',
    'role': '',
    'firstname': '',
    'lastname': '',
    'dob': '',
    'email': '',
    'password': '',
    'certifications': [
        {
          'certification_type': '',
          'certification_number': '',
          'certification_begindate': '',
          'certification_enddate': '',
          'certification': '',
        },
      ],
  };

  Map<String, dynamic>? get formData => _formData;


  void updateFormData(String key, String value) {
    _formData[key] = value.trim();
    notifyListeners();
  }

    void updateCertificationData(int index, String key, String value) {
    _formData['certifications'][index][key] = value;
    notifyListeners();
  }
}