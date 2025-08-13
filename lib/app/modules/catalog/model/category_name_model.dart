import 'dart:convert';

List<CategoryNameModel> catalogNameModelFromJson(String str) => List<CategoryNameModel>.from(json.decode(str).map((x) => CategoryNameModel.fromJson(x)));

String catalogNameModelToJson(List<CategoryNameModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryNameModel {
    String id;
    String category;

    CategoryNameModel({
        required this.id,
        required this.category,
    });

    factory CategoryNameModel.fromJson(Map<String, dynamic> json) => CategoryNameModel(
        id: json["id"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
    };
}