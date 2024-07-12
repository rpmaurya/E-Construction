import 'package:dio/dio.dart';
import 'package:e_basket/constant_file/Url.dart';
import 'package:e_basket/models/AddMoneyModel.dart';
import 'package:e_basket/models/BaseResponse.dart';
import 'package:e_basket/models/GetBillingDeatilsModel.dart';
import 'package:e_basket/models/GetBillingModel.dart';
import 'package:e_basket/models/GetWalletModel.dart';
import 'package:e_basket/models/RechargeHistoryModel.dart';
import 'package:e_basket/models/VerifyWalletModel.dart';
import 'package:e_basket/services/httpService.dart';
import 'package:flutter/material.dart';

class Walletservice {
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

  Future<RechargeHistoryModel?> getRechargeHistoryApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kRechargeHistoryEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..cartproduct': response?.data});

      var resp = RechargeHistoryModel.fromJson(response?.data);
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

  Future<GetBillingListModel?> getBillingHistoryApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kGetBillingHistoryEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..cartproduct': response?.data});

      var resp = GetBillingListModel.fromJson(response?.data);
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

  Future<GetBillingDetailModel?> getBillingDetailsApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kGetBillingDetailsEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..cartproduct': response?.data});

      var resp = GetBillingDetailModel.fromJson(response?.data);
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
