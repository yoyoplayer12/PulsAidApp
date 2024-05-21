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
    'privacy': '',
    'certifications': [
        {
          'certification_type': '',
          'certification_number': '',
          'certification_begindate': '',
          'certification_enddate': '',
          'certification': '',
        },
      ],
    'contact': [
      {
        'email': '',
        'phone': '',
        'facebook': '',
        'instagram': '',
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

  void updateContactData(String key, String value) {
    _formData['contact'][0][key] = value;
    notifyListeners();
  }
}