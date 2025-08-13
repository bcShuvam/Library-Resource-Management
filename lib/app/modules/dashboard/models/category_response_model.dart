import 'dart:convert';

CategoryResponseModel categoryResponseModelFromJson(String str) => CategoryResponseModel.fromJson(json.decode(str));

String categoryResponseModelToJson(CategoryResponseModel data) => json.encode(data.toJson());

class CategoryResponseModel {
  List<Category> categories;

  CategoryResponseModel({
    required this.categories,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => CategoryResponseModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  String id;
  String category;
  String description;
  bool status;
  DateTime createdAt;
  int v;
  DateTime? modifiedAt;

  Category({
    required this.id,
    required this.category,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.v,
    required this.modifiedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    category: json["category"],
    description: json["description"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    modifiedAt: json.containsKey("modifiedAt") && json["modifiedAt"] != null
        ? DateTime.parse(json["modifiedAt"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category,
    "description": description,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
    "modifiedAt": modifiedAt?.toIso8601String(),
  };
}
