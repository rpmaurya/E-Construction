import 'package:dio/dio.dart';
import 'package:e_basket/constant_file/Url.dart';
import 'package:e_basket/models/AddMoneyModel.dart';
import 'package:e_basket/models/BaseResponse.dart';
import 'package:e_basket/models/CartProductListModel.dart';
import 'package:e_basket/models/GetWalletModel.dart';
import 'package:e_basket/models/ProductListByCategoryIdModel.dart';
import 'package:e_basket/models/SearchProductListModel.dart';
import 'package:e_basket/models/SubcategoryModel.dart';
import 'package:e_basket/models/UpdateProductListModel.dart';
import 'package:e_basket/models/VerifyWalletModel.dart';
import 'package:e_basket/services/httpService.dart';
import 'package:flutter/material.dart';

class Cartmanagementservice {
  Future<ProductListByCategoryIdModel?> getProductListApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kGetProductListEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..product of categoryid': response?.data});

      var productListModel =
          ProductListByCategoryIdModel.fromJson(response?.data);
      return productListModel;
    } on DioException catch (error) {
      BaseResponseModel baseResponseModel =
          BaseResponseModel.fromJson(error.response?.data);
      print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
          context: context, error: error, errorResponse: baseResponseModel);
    }
    return null;
  }

  Future<SubCategoryModel?> getSubCategoryListApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kGetSubCategoryListEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var subCategoryList = SubCategoryModel.fromJson(response?.data);
      return subCategoryList;
    } on DioException catch (error) {
      BaseResponseModel baseResponseModel =
          BaseResponseModel.fromJson(error.response?.data);
      print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
          context: context, error: error, errorResponse: baseResponseModel);
    }
    return null;
  }

  Future<CartProductListModel?> getCartProductListApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kGetCartProductListEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..cartproduct': response?.data});

      var cartProductListModel = CartProductListModel.fromJson(response?.data);
      return cartProductListModel;
    } on DioException catch (error) {
      BaseResponseModel baseResponseModel =
          BaseResponseModel.fromJson(error.response?.data);
      print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
          context: context, error: error, errorResponse: baseResponseModel);
    }
    return null;
  }

  Future<UpdateProductListModel?> updateCartProductListApi(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kUpdateCartProductListEndUrl,
        methodType: HttpMethodType.PATCH,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..cartproduct': response?.data});

      var updatecartProductModel =
          UpdateProductListModel.fromJson(response?.data);
      return updatecartProductModel;
    } on DioException catch (error) {
      BaseResponseModel baseResponseModel =
          BaseResponseModel.fromJson(error.response?.data);
      print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
          context: context, error: error, errorResponse: baseResponseModel);
    }
    return null;
  }

  Future<bool?> addtoCartApi(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kAddtoCartEndUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});
      return true;
    } on DioException catch (error) {
      BaseResponseModel baseResponseModel =
          BaseResponseModel.fromJson(error.response?.data);
      print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
          context: context, error: error, errorResponse: baseResponseModel);
    }
    return null;
  }

  Future<SearchProductListModel?> searchtProductListApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kSearchListEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..search .': response?.data});

      var searchproductListModel =
          SearchProductListModel.fromJson(response?.data);
      return searchproductListModel;
    } on DioException catch (error) {
      BaseResponseModel baseResponseModel =
          BaseResponseModel.fromJson(error.response?.data);
      print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
          context: context, error: error, errorResponse: baseResponseModel);
    }
    return null;
  }

  Future<bool?> placeOrderApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kPlaceOrderEndUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});
      return true;
    } on DioException catch (error) {
      BaseResponseModel baseResponseModel =
          BaseResponseModel.fromJson(error.response?.data);
      print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
          context: context, error: error, errorResponse: baseResponseModel);
    }

    return null;
  }

  Future<GetWalletModel?> getWalletApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kGetWalletEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..cartproduct': response?.data});

      var cartProductListModel = GetWalletModel.fromJson(response?.data);
      return cartProductListModel;
    } on DioException catch (error) {
      BaseResponseModel baseResponseModel =
          BaseResponseModel.fromJson(error.response?.data);
      print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
          context: context, error: error, errorResponse: baseResponseModel);
    }
    return null;
  }

  Future<AddMoneyModel?> addWalletApi(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kAddWalletEndUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});
      var resp = AddMoneyModel.fromJson(response?.data);
      return resp;
    } on DioException catch (error) {
      BaseResponseModel baseResponseModel =
          BaseResponseModel.fromJson(error.response?.data);
      print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
          context: context, error: error, errorResponse: baseResponseModel);
    }
    return null;
  }

  Future<VerifyWalletModel?> verifyWalletApi(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kVerifyWalletEndUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});
      var resp = VerifyWalletModel.fromJson(response?.data);
      return resp;
    } on DioException catch (error) {
      BaseResponseModel baseResponseModel =
          BaseResponseModel.fromJson(error.response?.data);
      print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
          context: context, error: error, errorResponse: baseResponseModel);
    }
    return null;
  }
}
