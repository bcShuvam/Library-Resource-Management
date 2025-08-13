import 'dart:convert';

CategoryResponseModel categoryResponseModelFromJson(String str) =>
    CategoryResponseModel.fromJson(json.decode(str));

String categoryResponseModelToJson(CategoryResponseModel data) =>
    json.encode(data.toJson());

class CategoryResponseModel {
  List<Category>? categories;
  int? currentPage;
  int? totalPages;
  bool? hasNextPage;
  int? totalItems;
  int? limit;

  CategoryResponseModel({
    this.categories,
    this.currentPage,
    this.totalPages,
    this.hasNextPage,
    this.totalItems,
    this.limit,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoryResponseModel(
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        currentPage: json["pagination"]?["currentPage"],
        totalPages: json["pagination"]?["totalPages"],
        hasNextPage: json["pagination"]?["hasNextPage"],
        totalItems: json["pagination"]?["totalItems"],
        limit: json["pagination"]?["limit"],
      );

  Map<String, dynamic> toJson() => {
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "pagination": {
      "currentPage": currentPage,
      "totalPages": totalPages,
      "hasNextPage": hasNextPage,
      "totalItems": totalItems,
      "limit": limit,
    },
  };

  CategoryResponseModel copyWith({
    List<Category>? categories,
    int? currentPage,
    int? totalPages,
    bool? hasNextPage,
    int? totalItems,
    int? limitPerPage,
  }) {
    return CategoryResponseModel(
      categories: categories ?? this.categories,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      totalItems: totalItems ?? this.totalItems,
      limit: limitPerPage ?? this.limit,
    );
  }
}

class Category {
  String id;
  String category;
  String description;
  bool status;
  DateTime createdAt;
  int v;
  DateTime? modifiedAt;
  int totalItems;

  Category({
    required this.id,
    required this.category,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.v,
    required this.modifiedAt,
    required this.totalItems,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    category: json["category"],
    description: json["description"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    modifiedAt: json["modifiedAt"] == null
        ? null
        : DateTime.parse(json["modifiedAt"]),
    totalItems: json["totalItems"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category,
    "description": description,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
    "modifiedAt": modifiedAt?.toIso8601String(),
    "totalItems": totalItems,
  };
}
