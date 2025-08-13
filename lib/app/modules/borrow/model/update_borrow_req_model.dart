import 'dart:convert';

UpdateBorrowReq updateBorrowReqFromJson(String str) => UpdateBorrowReq.fromJson(json.decode(str));

String updateBorrowReqToJson(UpdateBorrowReq data) => json.encode(data.toJson());

class UpdateBorrowReq {
  String reqStatus;
  int quantity;
  String reqStatusDescription;

  UpdateBorrowReq({
    required this.reqStatus,
    required this.quantity,
    required this.reqStatusDescription,
  });

  factory UpdateBorrowReq.fromJson(Map<String, dynamic> json) => UpdateBorrowReq(
    reqStatus: json["reqStatus"],
    quantity: json["quantity"],
    reqStatusDescription: json["reqStatusDescription"],
  );

  Map<String, dynamic> toJson() => {
    "reqStatus": reqStatus,
    "quantity": quantity,
    "reqStatusDescription": reqStatusDescription,
  };
}