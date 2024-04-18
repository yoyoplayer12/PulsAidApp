import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager {
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

Future<Map<String, dynamic>> createUser(Map<String, String> registrationData) async {
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
    return jsonDecode(response.body);
  }if(response.statusCode == 401){
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login Status code: ${response.statusCode}');
  }
}
}