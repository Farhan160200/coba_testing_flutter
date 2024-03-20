class ResponseGetDataUser {
  final String address;
  final String city;
  final String createdAt;
  final String email;
  final int id;
  final String image;
  final int isAdmin;
  final String name;
  final String phone;
  final String updatedAt;
  final String username;

  ResponseGetDataUser({
    required this.address,
    required this.city,
    required this.createdAt,
    required this.email,
    required this.id,
    required this.image,
    required this.isAdmin,
    required this.name,
    required this.phone,
    required this.updatedAt,
    required this.username,
  });

  factory ResponseGetDataUser.fromJson(Map<String, dynamic> json) {
    return ResponseGetDataUser(
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      createdAt: json['created_at'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? 0,
      image: json['image'],
      isAdmin: json['isAdmin'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      username: json['username'] ?? '',
    );
  }
}
