import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager {
  static final ApiManager _singleton = ApiManager._internal();
  factory ApiManager() {
    return _singleton;
  }
  ApiManager._internal();
  String? _userId;
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

}