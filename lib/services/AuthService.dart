import 'package:dio/dio.dart';
import 'package:e_basket/Screens/login_screen/otp_verify_screen.dart';
import 'package:e_basket/constant_file/Url.dart';
import 'package:e_basket/models/BaseResponse.dart';
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
      
    }  catch (error) {
     print({'error..':error});
     http.handleErrorResponse(
        context: context,
        error: error,
      );
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
      
    }  catch (error) {
     print({'error..':error});
     http.handleErrorResponse(
        context: context,
        error: error,
      );
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
      
    }on DioException  catch (error) {
       var otpVerifyModel = OtpVerifyModel.fromJson(error.response?.data);
     print({'error..':error});
    //  http.handleErrorResponse(
    //     context: context,
    //     error: error,
    //   );
      Fluttertoast.showToast(msg: 'Your ${otpVerifyModel.status?.message}',backgroundColor: Colors.red,textColor: Colors.white);
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
      
    }  catch (error) {
     print({'error..':error});
     http.handleErrorResponse(
        context: context,
        error: error,
      );
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
      
    }  catch (error) {
     print({'error..':error});
     http.handleErrorResponse(
        context: context,
        error: error,
      );
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
      
    }  catch (error) {
     print({'error..':error});
     http.handleErrorResponse(
        context: context,
        error: error,
      );
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
      
    }  catch (error) {
     print({'error..':error});
     http.handleErrorResponse(
        context: context,
        error: error,
      );
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