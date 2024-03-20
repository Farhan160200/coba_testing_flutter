import 'dart:convert';

ResponseUserData responseUserDataFromJson(String str) =>
    ResponseUserData.fromJson(json.decode(str));

String responseUserDataToJson(ResponseUserData data) =>
    json.encode(data.toJson());

class ResponseUserData {
  final String name;
  final String email;
  final String username;
  final String image; // Tambahkan variabel image

  ResponseUserData({
    required this.name,
    required this.email,
    required this.username,
    required this.image, // Tambahkan inisialisasi image
  });

  factory ResponseUserData.fromJson(Map<String, dynamic> json) =>
      ResponseUserData(
        name: json['name'],
        email: json['email'],
        username: json['username'],
        image: json['image'], // Parsing image dari JSON
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'username': username,
    'image': image, // Menambahkan image ke dalam JSON
  };
}
