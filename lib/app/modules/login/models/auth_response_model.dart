import 'dart:convert';

AuthResponseModel authResponseModelFromJson(String str) => AuthResponseModel.fromJson(json.decode(str));

String authResponseModelToJson(AuthResponseModel data) => json.encode(data.toJson());

class AuthResponseModel {
  String message;
  String token;
  User user;

  AuthResponseModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
    message: json["message"],
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  String id;
  String fullName;
  String email;
  String photoUrl;
  String googleId;
  String role;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.photoUrl,
    required this.googleId,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    photoUrl: json["photoUrl"],
    googleId: json["googleId"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "photoUrl": photoUrl,
    "googleId": googleId,
    "role": role,
  };
}