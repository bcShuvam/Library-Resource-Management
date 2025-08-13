import 'dart:convert';

MyBorrowRequestListResponseModel myBorrowRequestListResponseModelFromJson(String str) =>
    MyBorrowRequestListResponseModel.fromJson(json.decode(str));

String myBorrowRequestListResponseModelToJson(MyBorrowRequestListResponseModel data) =>
    json.encode(data.toJson());

class MyBorrowRequestListResponseModel {
  String? message;
  List<BorrowRequest>? requests;

  MyBorrowRequestListResponseModel({
    this.message,
    this.requests,
  });

  factory MyBorrowRequestListResponseModel.fromJson(Map<String, dynamic> json) =>
      MyBorrowRequestListResponseModel(
        message: json["message"] as String?,
        requests: json["requests"] != null
            ? List<BorrowRequest>.from(
            json["requests"].map((x) => BorrowRequest.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "requests": requests != null
        ? List<dynamic>.from(requests!.map((x) => x.toJson()))
        : [],
  };
}

class BorrowRequest {
  String id;
  String userId;
  String catalogId;
  String catalogName;
  String catalogImage;
  String categoryId;
  String categoryName;
  int quantity;
  String description;
  String reqStatus;
  DateTime borrowReqDate;
  String? borrowReqApproveDate;
  DateTime returnDate;
  String? returnDueDate;
  String? returnStatus;
  bool? isDamaged;
  bool? isLost;
  String? comment;
  DateTime createdAt;
  String? modifiedAt;

  BorrowRequest({
    required this.id,
    required this.userId,
    required this.catalogId,
    required this.catalogName,
    required this.catalogImage,
    required this.categoryId,
    required this.categoryName,
    required this.quantity,
    required this.description,
    required this.reqStatus,
    required this.borrowReqDate,
    this.borrowReqApproveDate,
    required this.returnDate,
    this.returnDueDate,
    this.returnStatus,
    this.isDamaged,
    this.isLost,
    this.comment,
    required this.createdAt,
    this.modifiedAt,
  });

  factory BorrowRequest.fromJson(Map<String, dynamic> json) => BorrowRequest(
    id: json["_id"] ?? '',
    userId: json["userId"] ?? '',
    catalogId: json["catalogId"] ?? '',
    catalogName: json["catalogName"] ?? '',
    catalogImage: json["catalogImage"] ?? '', // safe
    categoryId: json["categoryId"] ?? '',
    categoryName: json["categoryName"] ?? '',
    quantity: json["quantity"] ?? 0,
    description: json["description"] ?? '',
    reqStatus: json["reqStatus"] ?? '',
    borrowReqDate: json["borrowReqDate"] != null
        ? DateTime.parse(json["borrowReqDate"])
        : DateTime.fromMillisecondsSinceEpoch(0),
    borrowReqApproveDate: json["borrowReqApproveDate"] as String?,
    returnDate: json["returnDate"] != null
        ? DateTime.parse(json["returnDate"])
        : DateTime.fromMillisecondsSinceEpoch(0),
    returnDueDate: json["returnDueDate"] as String?,
    returnStatus: json["returnStatus"] as String?,
    isDamaged: json["isDamaged"] as bool?,
    isLost: json["isLost"] as bool?,
    comment: json["comment"] as String?,
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.fromMillisecondsSinceEpoch(0),
    modifiedAt: json["modifiedAt"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "catalogId": catalogId,
    "catalogName": catalogName,
    "catalogImage": catalogImage,
    "categoryId": categoryId,
    "categoryName": categoryName,
    "quantity": quantity,
    "description": description,
    "reqStatus": reqStatus,
    "borrowReqDate": borrowReqDate.toIso8601String(),
    "borrowReqApproveDate": borrowReqApproveDate,
    "returnDate": returnDate.toIso8601String(),
    "returnDueDate": returnDueDate,
    "returnStatus": returnStatus,
    "isDamaged": isDamaged,
    "isLost": isLost,
    "comment": comment,
    "createdAt": createdAt.toIso8601String(),
    "modifiedAt": modifiedAt,
  };
}