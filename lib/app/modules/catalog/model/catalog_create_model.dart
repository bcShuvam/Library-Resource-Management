import 'dart:convert';

CatalogCreateModel catalogResponseModelFromJson(String str) => CatalogCreateModel.fromJson(json.decode(str));

String catalogResponseModelToJson(CatalogCreateModel data) => json.encode(data.toJson());

class CatalogCreateModel {
    String message;
    CatalogPayload catalogPayload;

    CatalogCreateModel({
        required this.message,
        required this.catalogPayload,
    });

    factory CatalogCreateModel.fromJson(Map<String, dynamic> json) => CatalogCreateModel(
        message: json["message"],
        catalogPayload: CatalogPayload.fromJson(json["catalog"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "catalog": catalogPayload.toJson(),
    };
}

class CatalogPayload {
    String? categoryId;
    String? name;
    String? description;
    int? quantity;
    bool? availabilityStatus;
    String? image;

    CatalogPayload({
        this.categoryId,
        this.name,
        this.description,
        this.quantity,
        this.image,
        this.availabilityStatus,
    });

    factory CatalogPayload.fromJson(Map<String, dynamic> json) => CatalogPayload(
        categoryId: json["categoryId"],
        name: json["name"],
        description: json["description"],
        quantity: json["quantity"],
        image: json["image"],
        availabilityStatus: json["availabilityStatus"]
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
        "description": description,
        "quantity": quantity,
        "image": image,
        "availabilityStatus": availabilityStatus,
    };
}