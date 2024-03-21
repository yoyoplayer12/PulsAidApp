import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager {
  Future<Map<String, dynamic>> fetchEmergencies() async {
    final response = await http
        .get(Uri.parse('https://pulsaidapi.onrender.com/api/v1/emergencies'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server returns an unsuccessful response code, throw an exception.
      throw Exception('Failed to load emergencies');
    }
  }
}
