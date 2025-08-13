import 'dart:convert';

BorrowRequestModel borrowRequestModelFromJson(String str) => BorrowRequestModel.fromJson(json.decode(str));

String borrowRequestModelToJson(BorrowRequestModel data) => json.encode(data.toJson());

class BorrowRequestModel {
  String catalogId;
  int quantity;
  String description;
  String returnDate;

  BorrowRequestModel({
    required this.catalogId,
    required this.quantity,
    required this.description,
    required this.returnDate,
  });

  factory BorrowRequestModel.fromJson(Map<String, dynamic> json) => BorrowRequestModel(
    catalogId: json["catalogId"],
    quantity: json["quantity"],
    description: json["description"],
    returnDate: json["returnDate"],
  );

  Map<String, dynamic> toJson() => {
    "catalogId": catalogId,
    "quantity": quantity,
    "description": description,
    "returnDate": returnDate,
  };
}