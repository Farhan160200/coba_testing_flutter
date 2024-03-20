import 'package:coba_testing_flutter/repository.dart';
import 'package:coba_testing_flutter/response_get_data_user.dart';
import 'package:flutter/material.dart';

// AkunViewModel
class AkunViewModel extends ChangeNotifier {
  final Repository repository;
  final String token;

  // Inisialisasi _userData dengan null
  ResponseGetDataUser? _userData;

  AkunViewModel(this.repository, this.token);

  ResponseGetDataUser? get userData => _userData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchData(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      _userData = await repository.getDataUser(token);
      print('Email: ${_userData!.email}');
      print('Name: ${_userData!.name}');
    } catch (e) {
      // Handle error
      print('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
