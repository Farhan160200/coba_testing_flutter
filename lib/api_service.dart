// ApiService
import 'dart:convert';
import 'package:coba_testing_flutter/response_get_data_user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://sobatps.devel-filkomub.site/api';

  static Future<ResponseGetDataUser> getDataUser(String token) async {
    final response = await http.get(Uri.parse('$baseUrl/user?token=$token'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ResponseGetDataUser.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}