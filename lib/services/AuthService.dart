import 'package:dio/dio.dart';
import 'package:e_basket/Screens/login_screen/otp_verify_screen.dart';
import 'package:e_basket/constant_file/Url.dart';
import 'package:e_basket/models/BaseResponse.dart';
import 'package:e_basket/models/BrandListModel.dart';
import 'package:e_basket/models/GetTopProductModel.dart';
import 'package:e_basket/models/LocationModel.dart';
import 'package:e_basket/models/categoryList_Model.dart';
import 'package:e_basket/models/login_model.dart';
import 'package:e_basket/models/otp_verify_model.dart';
import 'package:e_basket/models/register_model.dart';
import 'package:e_basket/models/user-model.dart';
import 'package:e_basket/services/httpService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authservice {
  LoginModel? loginModel;
  // String? senddata;
  Future<RegisterModel?> registerApi(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kRegisterEndUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();

      print({'response..': response?.data});

      var registerModel = RegisterModel.fromJson(response?.data);
      return registerModel;
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

  Future<LoginModel?> login(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kLoginByMobileUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var loginModel = LoginModel.fromJson(response?.data);
      return loginModel;
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

  //otp verification by mobile

  Future<OtpVerifyModel?> otpVerifyByMobile(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kOtpVerifyByMobEndUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var otpVerifyModel = OtpVerifyModel.fromJson(response?.data);
      return otpVerifyModel;
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

  ///login by email
  Future<LoginModel?> loginByEmail(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kLoginByEmailEndUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var loginModel = LoginModel.fromJson(response?.data);
      return loginModel;
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

  //otp verification by mobile

  Future<OtpVerifyModel?> otpVerifyEmail(
      {required Map<String, dynamic> body,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kOtpVerifyByEmailEndUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var otpVerifyModel = OtpVerifyModel.fromJson(response?.data);
      return otpVerifyModel;
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

  Future<UserModel?> getUserByIdApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kGetUserByIdEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var userModel = UserModel.fromJson(response?.data);
      return userModel;
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

  Future<UserModel?> editProfileByIdApi(
      {required Map<String, dynamic> body,
      required userId,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: '$kUpdateUserById/$userId',
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var userModel = UserModel.fromJson(response?.data);
      return userModel;
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

  Future<CategoryListModel?> getCategoryListApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kGetCategoryListEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var categoryListModel = CategoryListModel.fromJson(response?.data);
      return categoryListModel;
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

  Future<BrandListModel?> getBrandListApi(
      {required Map<String, dynamic> query,
      required BuildContext context,
      required Function setState}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: kUrlBase,
        endURL: kBrandListtEndUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var brandListModel = BrandListModel.fromJson(response?.data);
      return brandListModel;
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

  Future<GetTopProductModel?> getTopProductApi(
      {required BuildContext context, required Function setState}) async {
    var http = HttpService(
      isAuthorizeRequest: false,
      baseURL: kUrlBase,
      endURL: kGetTopProductEndUrl,
      methodType: HttpMethodType.GET,
      bodyType: HttpBodyType.JSON,
    );
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var resp = GetTopProductModel.fromJson(response?.data);
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

  Future<LocationModel?> getLocationApi(
      {required BuildContext context, required Function setState}) async {
    var http = HttpService(
      isAuthorizeRequest: false,
      baseURL: kUrlBase,
      endURL: kLocationEndUrl,
      methodType: HttpMethodType.GET,
      bodyType: HttpBodyType.JSON,
    );
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..': response?.data});

      var resp = LocationModel.fromJson(response?.data);
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
