// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
    Status? status;
    Data? data;

    CategoryListModel({
        this.status,
        this.data,
    });

    factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
    };
}

class Data {
    List<Content>? content;
    Pageable? pageable;
    int? totalElements;
    int? totalPages;
    bool? last;
    int? size;
    int? number;
    Sort? sort;
    int? numberOfElements;
    bool? first;
    bool? empty;

    Data({
        this.content,
        this.pageable,
        this.totalElements,
        this.totalPages,
        this.last,
        this.size,
        this.number,
        this.sort,
        this.numberOfElements,
        this.first,
        this.empty,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: json["content"] == null ? [] : List<Content>.from(json["content"]!.map((x) => Content.fromJson(x))),
        pageable: json["pageable"] == null ? null : Pageable.fromJson(json["pageable"]),
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        last: json["last"],
        size: json["size"],
        number: json["number"],
        sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
        numberOfElements: json["numberOfElements"],
        first: json["first"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
        "pageable": pageable?.toJson(),
        "totalElements": totalElements,
        "totalPages": totalPages,
        "last": last,
        "size": size,
        "number": number,
        "sort": sort?.toJson(),
        "numberOfElements": numberOfElements,
        "first": first,
        "empty": empty,
    };
}

class Content {
    int? categoryId;
    String? categoryName;
    String? imageurl;
    String? imageName;
    String? description;
    int? createdAt;
    int? updatedAt;
    List<SubCategory>? subCategories;

    Content({
        this.categoryId,
        this.categoryName,
        this.imageurl,
        this.imageName,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.subCategories,
    });

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        imageurl: json["imageurl"],
        imageName: json["imageName"],
        description: json["description"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        subCategories: json["subCategories"] == null ? [] : List<SubCategory>.from(json["subCategories"]!.map((x) => SubCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "imageurl": imageurl,
        "imageName": imageName,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "subCategories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
    };
}

class SubCategory {
    int? subCategoryId;
    String? subCategoryName;
    int? createdAt;
    int? updatedAt;

    SubCategory({
        this.subCategoryId,
        this.subCategoryName,
        this.createdAt,
        this.updatedAt,
    });

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        subCategoryId: json["subCategoryId"],
        subCategoryName: json["subCategoryName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "subCategoryId": subCategoryId,
        "subCategoryName": subCategoryName,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}

class Pageable {
    Sort? sort;
    int? pageNumber;
    int? pageSize;
    int? offset;
    bool? paged;
    bool? unpaged;

    Pageable({
        this.sort,
        this.pageNumber,
        this.pageSize,
        this.offset,
        this.paged,
        this.unpaged,
    });

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        offset: json["offset"],
        paged: json["paged"],
        unpaged: json["unpaged"],
    );

    Map<String, dynamic> toJson() => {
        "sort": sort?.toJson(),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "offset": offset,
        "paged": paged,
        "unpaged": unpaged,
    };
}

class Sort {
    bool? sorted;
    bool? empty;
    bool? unsorted;

    Sort({
        this.sorted,
        this.empty,
        this.unsorted,
    });

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        sorted: json["sorted"],
        empty: json["empty"],
        unsorted: json["unsorted"],
    );

    Map<String, dynamic> toJson() => {
        "sorted": sorted,
        "empty": empty,
        "unsorted": unsorted,
    };
}

class Status {
    String? httpCode;
    bool? success;
    String? message;

    Status({
        this.httpCode,
        this.success,
        this.message,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        httpCode: json["httpCode"],
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "httpCode": httpCode,
        "success": success,
        "message": message,
    };
}
