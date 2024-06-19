import 'package:dio/dio.dart';
import 'package:e_basket/constant_file/Url.dart';
import 'package:e_basket/models/AddSubscriptionModel.dart';
import 'package:e_basket/models/GetSubscriptionModel.dart';
import 'package:e_basket/models/ProductSubscriptionModel.dart';
import 'package:e_basket/models/UpdateSubscriptionModel.dart';
import 'package:e_basket/services/httpService.dart';
import 'package:flutter/material.dart';

class Subscriptionservice {
  Future<ProductSubscriptionModel?> addProductSubscriptionApi(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kAddProductSubscriptionEndUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var subscriptionresp = ProductSubscriptionModel.fromJson(response?.data);
      return subscriptionresp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(
        context: context,
        error: error,
      );
    }
    return null;
  }

  Future<UpdateSubscriptionModel?> updateSubscritionApi(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kUpdateSubscriptionEndUrl,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..subscription': response?.data});
      var resp = UpdateSubscriptionModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(
        context: context,
        error: error,
      );
    }
    return null;
  }

  Future<AddSubscriptionModel?> addSubscritionApi(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kAddSubscriptionEndUrl,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..subscription': response?.data});
      var resp = AddSubscriptionModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(
        context: context,
        error: error,
      );
    }
    return null;
  }

  Future<GetSubscriptionModel?> getSubscritionApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kGetSubscriptionEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..subscription': response?.data});
      var resp = GetSubscriptionModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(
        context: context,
        error: error,
      );
    }
    return null;
  }
}
