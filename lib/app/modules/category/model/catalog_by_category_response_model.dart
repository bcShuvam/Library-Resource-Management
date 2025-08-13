import 'dart:convert';

CatalogByCategoryResponseModel catalogByCategoryResponseModelFromJson(String str) => CatalogByCategoryResponseModel.fromJson(json.decode(str));

String catalogByCategoryResponseModelToJson(CatalogByCategoryResponseModel data) => json.encode(data.toJson());

class CatalogByCategoryResponseModel {
  String? message;
  CategoryDescription? category;
  List<Catalog>? catalogs;

  CatalogByCategoryResponseModel({
    this.message,
    this.category,
    this.catalogs,
  });

  factory CatalogByCategoryResponseModel.fromJson(Map<String, dynamic> json) => CatalogByCategoryResponseModel(
    message: json["message"],
    category: CategoryDescription.fromJson(json["category"]),
    catalogs: List<Catalog>.from(json["catalogs"].map((x) => Catalog.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "category": category!.toJson(),
    "catalogs": List<dynamic>.from(catalogs!.map((x) => x.toJson())),
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

class CategoryDescription {
  String id;
  String category;
  String description;
  int totalItems;

  CategoryDescription({
    required this.id,
    required this.category,
    required this.description,
    required this.totalItems,
  });

  factory CategoryDescription.fromJson(Map<String, dynamic> json) => CategoryDescription(
    id: json["_id"],
    category: json["category"],
    description: json["description"],
    totalItems: json["totalItems"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category,
    "description": description,
    "totalItems": totalItems,
  };
}