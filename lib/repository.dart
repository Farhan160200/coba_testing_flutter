// Repository
import 'package:coba_testing_flutter/api_service.dart';
import 'package:coba_testing_flutter/response_get_data_user.dart';

class Repository {
  final ApiService apiService;

  Repository(this.apiService);

  Future<ResponseGetDataUser> getDataUser(String token) {
    return ApiService.getDataUser(token);
  }
}