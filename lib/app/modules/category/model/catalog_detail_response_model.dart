import 'dart:convert';

CatalogDetailResponseModel catalogDetailResponseModelFromJson(String str) => CatalogDetailResponseModel.fromJson(json.decode(str));

String catalogDetailResponseModelToJson(CatalogDetailResponseModel data) => json.encode(data.toJson());

class CatalogDetailResponseModel {
  String? message;
  Catalog? catalog;

  CatalogDetailResponseModel({
    this.message,
    this.catalog,
  });

  factory CatalogDetailResponseModel.fromJson(Map<String, dynamic> json) => CatalogDetailResponseModel(
    message: json["message"],
    catalog: Catalog.fromJson(json["catalog"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "catalog": catalog!.toJson(),
  };
}

class Catalog {
  String id;
  String categoryId;
  String name;
  String description;
  int quantity;
  int borrowedQuantity;
  String image;
  bool availabilityStatus;
  DateTime createdAt;
  dynamic modifiedAt;
  int v;

  Catalog({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.quantity,
    required this.borrowedQuantity,
    required this.image,
    required this.availabilityStatus,
    required this.createdAt,
    required this.modifiedAt,
    required this.v,
  });

  factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
    id: json["_id"],
    categoryId: json["categoryId"],
    name: json["name"],
    description: json["description"],
    quantity: json["quantity"],
    borrowedQuantity: json["borrowedQuantity"],
    image: json["image"],
    availabilityStatus: json["availabilityStatus"],
    createdAt: DateTime.parse(json["createdAt"]),
    modifiedAt: json["modifiedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "categoryId": categoryId,
    "name": name,
    "description": description,
    "quantity": quantity,
    "borrowedQuantity": borrowedQuantity,
    "image": image,
    "availabilityStatus": availabilityStatus,
    "createdAt": createdAt.toIso8601String(),
    "modifiedAt": modifiedAt,
    "__v": v,
  };
}