import 'package:coba_testing_flutter/response_login.dart';
import 'package:coba_testing_flutter/response_user_data.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = 'https://sobatps.devel-filkomub.site/api';

  static Future<ResponseLogin> authLogin(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );
    print('API Login Response: ${response.statusCode} ${response.body}');

    if (response.statusCode == 200) {
      return responseLoginFromJson(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<ResponseUserData> getUserData(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('API GetUserData Response: ${response.statusCode} ${response.body}');

    if (response.statusCode == 200) {
      return responseUserDataFromJson(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
