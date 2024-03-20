import 'package:coba_testing_flutter/api_service.dart';
import 'package:coba_testing_flutter/response_user_data.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  ResponseUserData? _userData;
  bool _isLoading = false;
  String? _token;

  ResponseUserData? get userData => _userData;
  bool isLoading() => _isLoading;
  bool isLoggedIn() => _token != null;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.authLogin(email, password);
      _token = response.accessToken;
      _userData = await ApiService.getUserData(_token!);
    } catch (e) {
      print('Error: $e');
      _token = null;
      _userData = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  void logout() {
    _token = null;
    _userData = null;
    notifyListeners();
  }
}
