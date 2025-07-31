import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  String fullName;
  String email;
  String photoUrl;
  String googleId;

  AuthModel({
    required this.fullName,
    required this.email,
    required this.photoUrl,
    required this.googleId,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    fullName: json["fullName"],
    email: json["email"],
    photoUrl: json["photoUrl"],
    googleId: json["googleId"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "email": email,
    "photoUrl": photoUrl,
    "googleId": googleId,
  };
}