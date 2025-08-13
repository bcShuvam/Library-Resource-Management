import 'dart:convert';

CatalogResponseModel catalogResponseModelFromJson(String str) => CatalogResponseModel.fromJson(json.decode(str));

String catalogResponseModelToJson(CatalogResponseModel data) => json.encode(data.toJson());

class CatalogResponseModel {
    String message;
    Catalog catalog;

    CatalogResponseModel({
        required this.message,
        required this.catalog,
    });

    factory CatalogResponseModel.fromJson(Map<String, dynamic> json) => CatalogResponseModel(
        message: json["message"],
        catalog: Catalog.fromJson(json["catalog"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "catalog": catalog.toJson(),
    };
}

class Catalog {
    String categoryId;
    String name;
    String description;
    int quantity;
    int borrowedQuantity;
    String image;
    bool availabilityStatus;
    DateTime createdAt;
    dynamic modifiedAt;
    String id;
    int v;

    Catalog({
        required this.categoryId,
        required this.name,
        required this.description,
        required this.quantity,
        required this.borrowedQuantity,
        required this.image,
        required this.availabilityStatus,
        required this.createdAt,
        required this.modifiedAt,
        required this.id,
        required this.v,
    });

    factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
        categoryId: json["categoryId"],
        name: json["name"],
        description: json["description"],
        quantity: json["quantity"],
        borrowedQuantity: json["borrowedQuantity"],
        image: json["image"],
        availabilityStatus: json["availabilityStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: json["modifiedAt"],
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
        "description": description,
        "quantity": quantity,
        "borrowedQuantity": borrowedQuantity,
        "image": image,
        "availabilityStatus": availabilityStatus,
        "createdAt": createdAt.toIso8601String(),
        "modifiedAt": modifiedAt,
        "_id": id,
        "__v": v,
    };
}