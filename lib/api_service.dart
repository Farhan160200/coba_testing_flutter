import 'package:coba_testing_flutter/detail_movies_response.dart';
import 'package:coba_testing_flutter/detail_video_response.dart';
import 'package:coba_testing_flutter/response_get_all_movies.dart';
import 'package:coba_testing_flutter/response_login.dart';
import 'package:coba_testing_flutter/response_user_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiService {
  static const String baseUrl = 'https://sobatps.devel-filkomub.site/api';
  static const String baseUrlMovie = 'https://api.themoviedb.org/3';
  static const String apiKey = 'a6e717a2fd3abac91324810090ae62ff';

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
  static Future<GetAllMoviesResponse> getAllMovies() async {
    final response = await http.get(Uri.parse('$baseUrlMovie/movie/top_rated?api_key=$apiKey'));

    print('API getAllMovies Response: ${response.statusCode} ${response.body}');

    if (response.statusCode == 200) {
      return GetAllMoviesResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<GetAllMoviesResponse> getAllUpcomingMovies() async {
    final response = await http.get(Uri.parse('$baseUrlMovie/movie/upcoming?api_key=$apiKey'));

    print('API getUpcoming Response: ${response.statusCode} ${response.body}');

    if (response.statusCode == 200) {
      return GetAllMoviesResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<GetAllMoviesResponse> getNowPlaying() async {
    final response = await http.get(Uri.parse('$baseUrlMovie/movie/now_playing?api_key=$apiKey'));

    print('API getLatest Response: ${response.statusCode} ${response.body}');

    if (response.statusCode == 200) {
      return GetAllMoviesResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<DetailMoviesResponse> getDetailMovie(int movieId) async {
    final response = await http.get(
      Uri.parse('$baseUrlMovie/movie/$movieId?api_key=$apiKey'),
    );

    print('API Detail Movie Response: ${response.statusCode} ${response.body}');

    if (response.statusCode == 200) {
      return DetailMoviesResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  static Future<VideoResponse> getDetailVideo(int movieId) async {
    final response = await http.get(
      Uri.parse('$baseUrlMovie/movie/$movieId/videos?api_key=$apiKey'),
    );

    print('API Detail Video Response: ${response.statusCode} ${response.body}');

    if (response.statusCode == 200) {
      return VideoResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }


}
