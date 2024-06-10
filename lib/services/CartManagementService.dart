import 'package:dio/dio.dart';
import 'package:e_basket/constant_file/Url.dart';
import 'package:e_basket/models/CartProductListModel.dart';
import 'package:e_basket/models/ProductListByCategoryIdModel.dart';
import 'package:e_basket/models/SubcategoryModel.dart';
import 'package:e_basket/models/UpdateProductListModel.dart';
import 'package:e_basket/services/httpService.dart';
import 'package:flutter/material.dart';

class Cartmanagementservice{
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
      print({'response..': response?.data});
     
      var productListModel = ProductListByCategoryIdModel.fromJson(response?.data);
        return productListModel;
      
    }  catch (error) {
     print({'error..':error});
     http.handleErrorResponse(
        context: context,
        error: error,
      );
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
      
    }  catch (error) {
     print({'error..':error});
     http.handleErrorResponse(
        context: context,
        error: error,
      );
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
      
    }  catch (error) {
     print({'error..':error});
     http.handleErrorResponse(
        context: context,
        error: error,
      );
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
     
      var updatecartProductModel = UpdateProductListModel.fromJson(response?.data);
        return updatecartProductModel;
      
    }  catch (error) {
     print({'error..':error});
     http.handleErrorResponse(
        context: context,
        error: error,
      );
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
     
      
    }  catch (error) {
     print({'error..':error});
     http.handleErrorResponse(
        context: context,
        error: error,
      );
    }
   return null;
  }
}