import 'dart:convert';

ProfileResponseModel profileResponseModelFromJson(String str) => ProfileResponseModel.fromJson(json.decode(str));

String profileResponseModelToJson(ProfileResponseModel data) => json.encode(data.toJson());

class ProfileResponseModel {
  String? id;
  String? fullName;
  String? email;
  String? photoUrl;
  String? googleId;
  String? role;
  dynamic? fbToken;
  bool? hasFbToken;
  DateTime? createdAt;
  dynamic? modifiedAt;
  int? v;

  ProfileResponseModel({
    this.id,
    this.fullName,
    this.email,
    this.photoUrl,
    this.googleId,
    this.role,
    this.fbToken,
    this.hasFbToken,
    this.createdAt,
    this.modifiedAt,
    this.v,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    photoUrl: json["photoUrl"],
    googleId: json["googleId"],
    role: json["role"],
    fbToken: json["fbToken"],
    hasFbToken: json["hasFbToken"],
    createdAt: DateTime.parse(json["createdAt"]),
    modifiedAt: json["modifiedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "photoUrl": photoUrl,
    "googleId": googleId,
    "role": role,
    "fbToken": fbToken,
    "hasFbToken": hasFbToken,
    "createdAt": createdAt!.toIso8601String(),
    "modifiedAt": modifiedAt,
    "__v": v,
  };
}