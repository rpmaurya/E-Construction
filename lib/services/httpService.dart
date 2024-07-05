import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_basket/constant_file/String.dart';
import 'package:e_basket/constant_file/Url.dart';
import 'package:e_basket/models/BaseResponse.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HttpService<T> {
  Dio? _http;
  String? baseURL;
  final String? endURL;
  final HttpMethodType? methodType;
  Map<String, dynamic>? queryParameters;
  // {
  //   "key1":1,
  //   "key1":1,
  //   "key1":1,
  //   "key1":1,
  //   "key1":"1",
  //   "key1":"1"
  // }
  final HttpBodyType? bodyType;
  Map<String, dynamic>? body;
  Map<String, String>? headers;
  int? responseStatusCode;
  bool isAuthorizeRequest;

  HttpService({
    this.baseURL,
    this.endURL,
    this.methodType,
    this.queryParameters,
    this.body,
    this.bodyType = HttpBodyType.JSON,
    this.headers,
    this.isAuthorizeRequest = true,
  }) {
    if (this.baseURL == null) {
      this.baseURL = kUrlBase;
      // this.baseURL = "http://3.110.83.101:9000/";
    }
    _http = Dio();
  }

  // isAuthorizeRequest() {
  //   // if (_auth.isAuthenticated) {

  //   if (this.headers == null) {
  //     this.headers = Map<String, String>();
  //   }
  //   this.headers!.addAll({
  //     "Authorization": "Bearer " +
  //         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWRlZmZjMGQ1MjE1NjI5MGIyYTgwOTYiLCJuYW1lIjoibWFkaHVzdSIsImVtYWlsIjoibXNzc2RAZ21hb2lsbC5mamYiLCJwaG9uZU51bWJlciI6IjkxODk3ODc3Njc2NyIsImlhdCI6MTY0MjAwNDQyMiwiZXhwIjoxNjQyODY4NDIyfQ.585EsMwtKGXQK3AJX8coewikknodm-Kqbr7dquzoKVk"
  //   });
  //   // }
  // }
  authorizeRequest() async {
    if (this.headers == null) {
      this.headers = <String, String>{};
    }
    this.headers?.addAll({"Authorization": "Bearer " + "$kToken"});
    print(this.headers);

    // this.headers!.addAll({"token": "${_auth.authenticationToken}"});
    // print({'token....jhjh': this.headers});
  }

  Future<Response<T>>? request<T>() {
    dynamic bodyData;
    if (this.headers == null) {
      this.headers = <String, String>{};
    }
    if (isAuthorizeRequest) {
      authorizeRequest();
    }

    // Body Type check
    print({"this.bodyType": this.bodyType});
    print({"post body": this.body});

    switch (this.bodyType) {
      case HttpBodyType.FormData:
        this.headers?.addAll({
          'Content-Type': 'application/x-www-form-urlencoded',
        });
        bodyData = this.body != null ? FormData.fromMap(this.body!) : null;
        break;
      case HttpBodyType.JSON:
        this.headers?.addAll({
          'Content-Type': 'application/json',
        });
        bodyData = this.body != null ? jsonEncode(this.body) : null;
        break;
      case HttpBodyType.XML:
        bodyData = this.body!["data"];
        break;
      default:
        bodyData = this.body;
        break;
    }

    // Method Type check
    print({"this.methodType": this.methodType});
    print({
      "URL": this.baseURL! + this.endURL!,
      "queryParameters": queryParameters
    });
    switch (this.methodType) {
      case HttpMethodType.GET:
        print("Getapicall");
        print({"call": this.headers});
        return _http!.get<T>(
          this.baseURL! + this.endURL!,
          queryParameters: this.queryParameters,
          options: Options(
            headers: this.headers,
            validateStatus: (status) {
              this.responseStatusCode = status!;
              return status < 300;
            },
            receiveDataWhenStatusError: true,
          ),
        );
        break;
      case HttpMethodType.POST:
        // FormData dataaa = bodyData;
        print({"bodyData formdata": bodyData});
        print({"baseUrl": this.baseURL! + this.endURL!});
        return _http!.post<T>(
          this.baseURL! + this.endURL!,
          queryParameters: this.queryParameters,
          data: bodyData,
          options: Options(
            headers: this.headers,
            contentType: this.headers?["Content-Type"],
            validateStatus: (status) {
              this.responseStatusCode = status!;
              return status < 300;
            },
            receiveDataWhenStatusError: true,
          ),
        );
        break;
      case HttpMethodType.PUT:
        return _http!.put<T>(
          this.baseURL! + this.endURL!,
          queryParameters: this.queryParameters,
          data: bodyData,
          options: Options(
            headers: this.headers,
            validateStatus: (status) {
              this.responseStatusCode = status!;
              return status < 300;
            },
            receiveDataWhenStatusError: true,
          ),
        );
        break;
      case HttpMethodType.PATCH:
        return _http!.patch<T>(
          this.baseURL! + this.endURL!,
          queryParameters: this.queryParameters,
          data: bodyData,
          options: Options(
            headers: this.headers,
            validateStatus: (status) {
              this.responseStatusCode = status!;
              return status < 300;
            },
            receiveDataWhenStatusError: true,
          ),
        );
        break;
      case HttpMethodType.DELETE:
        print({
          "URL": this.baseURL! + this.endURL!,
          "queryParameters": queryParameters
        });
        return _http!.delete<T>(
          this.baseURL! + this.endURL!,
          queryParameters: this.queryParameters,
          data: bodyData,
          options: Options(
            headers: this.headers,
            validateStatus: (status) {
              this.responseStatusCode = status!;
              return status < 300;
            },
            receiveDataWhenStatusError: true,
          ),
        );
        break;
      default:
        return null;
    }
  }

  handleErrorResponse({
    BuildContext? context,
    dynamic error,
    BaseResponseModel? errorResponse,
    bool tryParse = true,
    Function? postHandleError,
    bool isLogin = false,
  }) {
    String? message;
    // if (error != null && tryParse) {
    //   try {
    //     print({"error.response?.data": error.response?.data});
    //     message =
    //         '${error.response?.data["message"] ?? error.response?.data["errors"][0]["msg"]}';
    //   } catch (error) {
    //     message = null;
    //   }
    // }
    message = errorResponse?.status?.message;
    responseStatusCode = int.parse(errorResponse?.status?.httpCode ?? '');
    switch (this.responseStatusCode) {
      case 200:
        // Fluttertoast.showToast(msg: kStringSomethingWentWrong);
        return;
      case 301:
        // bad request
        // print({"error 400": error.response.data["message"]});
        if (message != null) {
          Fluttertoast.showToast(msg: message);
          break;
        } else {
          Fluttertoast.showToast(msg: kStringBadRequest);
        }
        break;
      case 400:
        // bad request
        // print({"error 400": error.response.data["message"]});
        if (message != null) {
          Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
          break;
        } else {
          Fluttertoast.showToast(msg: kStringBadRequest);
        }
        break;
      case 401:
        // unauthorize
        if (!isLogin) {
          Fluttertoast.showToast(msg: message ?? kStringSessionTimeout);
          // _auth.unauthenticateUser(context!);
          return;
        } else {
          Fluttertoast.showToast(msg: kStringInvalidCredentials);
        }
        break;
      case 404:
        // Forbidden
        if (message != null) {
          Fluttertoast.showToast(msg: message);
          break;
        }
        Fluttertoast.showToast(msg: kStringForbidden);
        break;
      case 500:
        // internal server error
        if (message != null) {
          Fluttertoast.showToast(msg: message);
          break;
        }
        Fluttertoast.showToast(msg: kStringServerError);
        break;
      default:
        if (message != null) {
          Fluttertoast.showToast(msg: message);
          break;
        }
        Fluttertoast.showToast(msg: kStringSomethingWentWrong);
        break;
    }
    if (postHandleError != null) {
      postHandleError();
    }
  }
}

enum HttpMethodType { GET, POST, PUT, PATCH, DELETE }

enum HttpBodyType { FormData, JSON, XML }
