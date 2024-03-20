import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  final String accessToken;
  final int expiresIn;
  final String tokenType;

  ResponseLogin({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
    accessToken: json["access_token"],
    expiresIn: json["expires_in"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "expires_in": expiresIn,
    "token_type": tokenType,
  };
}
