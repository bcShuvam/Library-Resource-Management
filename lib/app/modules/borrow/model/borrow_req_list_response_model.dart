import 'dart:convert';

BorrowRequestListResponseModel borrowRequestListResponseModelFromJson(String str) =>
    BorrowRequestListResponseModel.fromJson(json.decode(str));

String borrowRequestListResponseModelToJson(BorrowRequestListResponseModel data) =>
    json.encode(data.toJson());

class BorrowRequestListResponseModel {
  String? message;
  Pagination? pagination;
  List<BorrowRequestList>? requests;

  BorrowRequestListResponseModel({
    this.message,
    this.pagination,
    this.requests,
  });

  factory BorrowRequestListResponseModel.fromJson(Map<String, dynamic> json) =>
      BorrowRequestListResponseModel(
        message: json["message"],
        pagination: json["pagination"] != null
            ? Pagination.fromJson(json["pagination"])
            : null,
        requests: json["requests"] != null
            ? List<BorrowRequestList>.from(
            json["requests"].map((x) => BorrowRequestList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "pagination": pagination?.toJson(),
    "requests": requests != null
        ? List<dynamic>.from(requests!.map((x) => x.toJson()))
        : [],
  };
}

class Pagination {
  int? totalItems;
  int? currentPage;
  int? limit;
  bool? hasNextPage;

  Pagination({
    this.totalItems,
    this.currentPage,
    this.limit,
    this.hasNextPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalItems: json["totalItems"] ?? 0,
    currentPage: json["currentPage"] ?? 0,
    limit: json["limit"] ?? 0,
    hasNextPage: json["hasNextPage"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems,
    "currentPage": currentPage,
    "limit": limit,
    "hasNextPage": hasNextPage,
  };
}

class BorrowRequestList {
  String? id;
  User? user;
  Catalog? catalog;
  Category? category;
  int? quantity;
  String? description;
  String? reqStatus;
  DateTime? borrowReqDate;
  DateTime? borrowReqApproveDate;
  DateTime? borrowReqRejectDate;
  String? reqStatusDescription;
  DateTime? returnDate;
  DateTime? returnDueDate;
  String? returnStatus;
  bool? isDamaged;
  bool? isLost;
  String? comment;
  DateTime? createdAt;
  DateTime? modifiedAt;

  BorrowRequestList({
    this.id,
    this.user,
    this.catalog,
    this.category,
    this.quantity,
    this.description,
    this.reqStatus,
    this.borrowReqDate,
    this.borrowReqApproveDate,
    this.borrowReqRejectDate,
    this.reqStatusDescription,
    this.returnDate,
    this.returnDueDate,
    this.returnStatus,
    this.isDamaged,
    this.isLost,
    this.comment,
    this.createdAt,
    this.modifiedAt,
  });

  factory BorrowRequestList.fromJson(Map<String, dynamic> json) =>
      BorrowRequestList(
        id: json["_id"] ?? '',
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        catalog:
        json["catalog"] != null ? Catalog.fromJson(json["catalog"]) : null,
        category: json["category"] != null
            ? Category.fromJson(json["category"])
            : null,
        quantity: json["quantity"] ?? 0,
        description: json["description"] ?? '',
        reqStatus: json["reqStatus"] ?? '',
        borrowReqDate: json["borrowReqDate"] != null
            ? DateTime.tryParse(json["borrowReqDate"])
            : null,
        borrowReqApproveDate: json["borrowReqApproveDate"] != null
            ? DateTime.tryParse(json["borrowReqApproveDate"])
            : null,
        borrowReqRejectDate: json["borrowReqRejectDate"] != null
            ? DateTime.tryParse(json["borrowReqRejectDate"])
            : null,
        reqStatusDescription: json["reqStatusDescription"] ?? '',
        returnDate: json["returnDate"] != null
            ? DateTime.tryParse(json["returnDate"])
            : null,
        returnDueDate: json["returnDueDate"] != null
            ? DateTime.tryParse(json["returnDueDate"])
            : null,
        returnStatus: json["returnStatus"],
        isDamaged: json["isDamaged"],
        isLost: json["isLost"],
        comment: json["comment"],
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"])
            : null,
        modifiedAt: json["modifiedAt"] != null
            ? DateTime.tryParse(json["modifiedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "catalog": catalog?.toJson(),
    "category": category?.toJson(),
    "quantity": quantity,
    "description": description,
    "reqStatus": reqStatus,
    "borrowReqDate": borrowReqDate?.toIso8601String(),
    "borrowReqApproveDate": borrowReqApproveDate?.toIso8601String(),
    "borrowReqRejectDate": borrowReqRejectDate?.toIso8601String(),
    "reqStatusDescription": reqStatusDescription,
    "returnDate": returnDate?.toIso8601String(),
    "returnDueDate": returnDueDate?.toIso8601String(),
    "returnStatus": returnStatus,
    "isDamaged": isDamaged,
    "isLost": isLost,
    "comment": comment,
    "createdAt": createdAt?.toIso8601String(),
    "modifiedAt": modifiedAt?.toIso8601String(),
  };
}

class Catalog {
  String? id;
  String? name;
  int? quantity;
  int? borrowedQuantity;
  int? availableQuantity;
  String? image;

  Catalog({
    this.id,
    this.name,
    this.quantity,
    this.borrowedQuantity,
    this.availableQuantity,
    this.image,
  });

  factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    quantity: json["quantity"] ?? 0,
    borrowedQuantity: json["borrowedQuantity"] ?? 0,
    availableQuantity: json["availableQuantity"] ?? 0,
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "quantity": quantity,
    "borrowedQuantity": borrowedQuantity,
    "availableQuantity": availableQuantity,
    "image": image,
  };
}

class Category {
  String? id;
  String? category;

  Category({
    this.id,
    this.category,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"] ?? '',
    category: json["category"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category,
  };
}

class User {
  String? id;
  String? fullName;
  String? email;
  String? photoUrl;

  User({
    this.id,
    this.fullName,
    this.email,
    this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] ?? '',
    fullName: json["fullName"] ?? '',
    email: json["email"] ?? '',
    photoUrl: json["photoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "photoUrl": photoUrl,
  };
}
