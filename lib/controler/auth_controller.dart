import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthController {
  final String _baseUrl = 'http://localhost:3001';

  Future<bool> registerUser(String name, String email, String phone, String password) async {
    try {
      final url = Uri.parse('$_baseUrl/api/users');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return true; // Registration successful
      } else {
        print('Failed to register user: ${response.body}');
        return false; // Registration failed
      }
    } catch (e) {
      print('Error registering user: $e');
      return false; // Return false if an exception is caught
    }
  }
}
