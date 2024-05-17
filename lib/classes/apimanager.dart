import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiManager {
   static final ApiManager _singleton = ApiManager._internal();
  factory ApiManager() {
    return _singleton;
  }
  ApiManager._internal() {
    _loadUserId();
  }
  String? _userId;

  void _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('user');
  }
  
  Future<Map<String, dynamic>> fetchEmergencies() async {
    final response = await http
        .get(Uri.parse('https://api.pulsaid.be/api/v1/emergencies'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server returns an unsuccessful response code, throw an exception.
      throw Exception('Failed to load emergencies');
    }
  }

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> registrationData) async {
      final response = await http.post(
      Uri.parse('https://api.pulsaid.be/api/v1/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registrationData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create user Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> loginUser(Map<String, String> loginData) async {
    final response = await http.post(
      Uri.parse('https://api.pulsaid.be/api/v1/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginData),
    );


    if (response.statusCode == 200) {
      _userId = jsonDecode(response.body)['id'];
      return jsonDecode(response.body);
    }if(response.statusCode == 401){
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login Status code: ${response.statusCode}');
    }
  }

  String? getUserId() {
    return _userId;
  }

  Future<Map<String, dynamic>> userInfo() async {
    final response = await http.get(
      Uri.parse('https://api.pulsaid.be/api/v1/users/$_userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user info Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> checkEmail(email) async {
    final response = await http.post(
      Uri.parse('https://api.pulsaid.be/api/v1/users/checkemail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if(response.statusCode == 401){
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to check email Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> addCertificate(Map<String, dynamic> certificateData) async {
    final response = await http.post(
      Uri.parse('https://api.pulsaid.be/api/v1/users/$_userId/certificate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(certificateData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add certificate Status code: ${response.statusCode}');
    }

  }

  Future<Map<String, dynamic>> editCertificate(Map<String, dynamic> certificateData, String certificateId) async {
    final response = await http.put(
      Uri.parse('https://api.pulsaid.be/api/v1/users/$_userId/certificate/$certificateId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(certificateData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit certificate Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> saveUserInfo(firstname, lastname, email, dob, [String? password]) async {
    Map<String, dynamic> body = {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'dob': dob,
    };

    if (password != null && password.isNotEmpty) {
      body['password'] = password;
    }

    final response = await http.put(
      Uri.parse('https://api.pulsaid.be/api/v1/users/$_userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to save user info Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> changeAccountType(role) async {
    Map<String, dynamic> body = {
      'role': role, 
    };


    final response = await http.put(
      Uri.parse('https://api.pulsaid.be/api/v1/users/$_userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to save user info Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> deleteAccount() async {
    final response = await http.delete(
      Uri.parse('https://api.pulsaid.be/api/v1/users/$_userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete certificate Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> sendConversation(option, input ) async {
    final response = await http.post(
      Uri.parse('https://api.pulsaid.be/api/v1/conversations/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'option': option, 'applicantContactq': input, 'applicant': _userId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete certificate Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> updateEmergenciesFeedback(way, usability, feedback, id) async {
    final response = await http.put(
      Uri.parse('https://api.pulsaid.be/api/v1/emergencies/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'feedback':{
            'way': way,
            'usability': usability,
            'feedback': feedback,
          }
        }
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch conversations Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> addDoNotDisturb(Map<String, dynamic> formData) async {
    final response = await http.post(
      Uri.parse('https://api.pulsaid.be/api/v1/availibilities/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'user': _userId,
        'startdate': formData['startDateTime']!.toIso8601String(),
        'enddate': formData['endDateTime']!.toIso8601String(),
        'repeat': formData['repeat']!
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add do not disturb Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchDoNotDisturb() async {
    final response = await http.get(
      Uri.parse('https://api.pulsaid.be/api/v1/availibilities/$_userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch certificates Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> amountOfEmergencies() async {
    final response = await http.get(
      Uri.parse('https://api.pulsaid.be/api/v1/emergencies/amount/$_userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete do not disturb Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> saveRecoveryCode(int recoverycode, String email) async {
    Map<String, dynamic> body = {'recoveryCode': recoverycode};
    final response = await http.put(
      Uri.parse('https://api.pulsaid.be/api/v1/users/$email/recovery'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
  
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to save user info Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> checkRecoveryCode(String recoveryCode, String email) async{
    final response = await http.post(
      Uri.parse('https://api.pulsaid.be/api/v1/users/$email/recovery'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'recoveryCode': recoveryCode}),
    );

      return jsonDecode(response.body);
  }

    Future<Map<String, dynamic>> passwordChange(String password, String email) async {
    Map<String, dynamic> body = {'password': password};
    final response = await http.put(
      Uri.parse('https://api.pulsaid.be/api/v1/users/$email/recovery'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
  
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to save user info Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getNotifications() async {
    final response = await http.get(
      Uri.parse('https://api.pulsaid.be/api/v1/sideNotifications/$_userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch notifications Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> updateUsersNotifications(bool value) async {
    final response = await http.put(
      Uri.parse('https://api.pulsaid.be/api/v1/users/$_userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'notifications': value}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update notifications Status code: ${response.statusCode}');
    }
  }
  
}