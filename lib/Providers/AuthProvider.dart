// TODO Implement this library.
import 'package:e_basket/Screens/bottom_bar_screen/OtpVerifyByProfileScreen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:e_basket/Screens/login_screen/login_screen.dart';
import 'package:e_basket/Screens/login_screen/otp_verify_screen.dart';
import 'package:e_basket/models/BrandListModel.dart';
import 'package:e_basket/models/GetTopProductModel.dart';
import 'package:e_basket/models/LocationModel.dart';
import 'package:e_basket/models/categoryList_Model.dart';
import 'package:e_basket/models/login_model.dart';
import 'package:e_basket/models/otp_verify_model.dart';
import 'package:e_basket/models/user-model.dart';
import 'package:e_basket/services/AuthService.dart';
import 'package:e_basket/utils/sharepreferences_file.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController locationController = TextEditingController();
  int? locationId;
  Authservice authservice = Authservice();
  UserModel? userModel;
  CategoryListModel? categoryListModel;
  BrandListModel? brandListModel;
  GetTopProductModel? getTopProductModel;
  LocationModel? locationModel;
  bool isLoding = false;

  Future registerUser({
    required BuildContext context,
    required Function setState,
    required lat,
    required lng,
    required timezone,
  }) async {
    setState(() {
      isLoding = true;
    });
    Map<String, dynamic> body = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": userEmail.text,
      "mobileNo": phoneNumber.text,
      "lat": lat,
      "lon": lng,
      "timezone": timezone,
      "location": locationController.text,
      "countryCode": "91"
    };
    print({'body...': body});

    try {
      await authservice
          .registerApi(body: body, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          Fluttertoast.showToast(
              backgroundColor: Colors.green,
              msg: '${value?.status?.message}',
              textColor: Colors.white);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          setState(() {
            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'errror': e});
    }
  }

  Future loginByMobile({
    required BuildContext context,
    required Function setState,
  }) async {
    setState(() {
      isLoding = true;
    });
    print({'phone Number...': phoneController.text});
    // print({'phone number........': number.toString()});
    Map<String, dynamic> body = {"mobile": phoneController.text};
    try {
      await authservice
          .login(body: body, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          Fluttertoast.showToast(
              backgroundColor: Colors.green,
              msg: '${value?.status?.message}',
              textColor: Colors.white);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpVerifyScreen(
                        subtitle: value?.status?.message ?? '',
                        resp: value,
                      )));
          setState(() {
            isLoding = false;
          });
          notifyListeners();
        }
      });
    } catch (e) {
      print({'errror': e});
    }
  }

  Future<void> otpVerify(
      {required BuildContext context, required setState, required data}) async {
    Map<String, dynamic> body = {"mobile": data, "otp": otpController.text};
    print({'otpverification...': body});
    try {
      setState(() {
        isLoding = true;
      });
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await authservice
          .otpVerifyByMobile(body: body, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          // SharepreferencClass().clearData();
          // SharepreferencClass()
          //     .saveUser(value?.data?.token ?? '', value?.data?.userId ?? 0);
          sharedPreferences.setInt('userId', value?.data?.userId ?? 0);
          sharedPreferences.setString('token', value?.data?.token ?? '');
          Fluttertoast.showToast(
              msg: value?.status?.message ?? '',
              backgroundColor: Colors.green,
              textColor: Colors.white);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const BottomBarScreen()));
          notifyListeners();
          setState(() {
            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future loginByEmail({
    required BuildContext context,
    required Function setState,
  }) async {
    setState(() {
      isLoding = true;
    });
    print({'email....': emailController.text});
    Map<String, dynamic> body = {"email": emailController.text};
    try {
      await authservice
          .loginByEmail(body: body, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          Fluttertoast.showToast(
              backgroundColor: Colors.green,
              msg: '${value?.status?.message}',
              textColor: Colors.white);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpVerifyScreen(
                        subtitle: value?.status?.message ?? '',
                        resp: value,
                      )));
        }
      });
    } catch (e) {
      print({'errror': e});
    }
  }

  Future<OtpVerifyModel?> otpVerifyByEmail(
      {required BuildContext context, required setState, required data}) async {
    Map<String, dynamic> body = {"email": data, "otp": otpController.text};
    print({'otpverification...': body});
    try {
      setState(() {
        isLoding = true;
      });
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var resp = await authservice
          .otpVerifyEmail(body: body, context: context, setState: setState)
          .then((onValue) {
        if (onValue?.status?.httpCode == '200') {
          // SharepreferencClass().clearData();
          sharedPreferences.setInt('userId', onValue?.data?.userId ?? 0);
          sharedPreferences.setString('token', onValue?.data?.token ?? '');
          // SharepreferencClass()
          //     .saveUser(onValue?.data?.token ?? '', onValue?.data?.userId ?? 0);
          notifyListeners();
          setState(() {
            isLoding = false;
          });
          return onValue;
        }
      });
      return resp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<void> getUserById(
      {required BuildContext context, required setState, userId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');

    Map<String, dynamic> query = {"userId": getid ?? userId};
    print({'getid...': query});
    try {
      setState(() {
        isLoding = true;
      });
      await authservice
          .getUserByIdApi(query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            userModel = value;
            notifyListeners();

            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future<void> editProfileById(
      {required BuildContext context,
      required setState,
      required lat,
      required lng,
      required timeZone}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');

    Map<String, dynamic> body = {
      "firstName": firstName.text,
      "lastName": lastName.text,
      "email": email.text,
      "lat": lat,
      "lon": lng,
      "timezone": timeZone,
      "location": locationController.text
    };
    print({'getid...': body});
    try {
      setState(() {
        isLoding = true;
      });
      await authservice
          .editProfileByIdApi(
              body: body, userId: getid, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          if (email.text == userModel?.data?.email) {
            Fluttertoast.showToast(
                backgroundColor: Colors.green,
                msg: '${value?.status?.message}',
                textColor: Colors.white);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const BottomBarScreen()),
              (Route<dynamic> route) => false,
            );
          } else {
            Fluttertoast.showToast(
                backgroundColor: Colors.green,
                msg: 'otp sent successfully',
                textColor: Colors.white);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Otpverifybyprofilescreen(
                          editResp: value,
                        )));
          }

          setState(() {
            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future<void> getCategoryList({
    required BuildContext context,
    required setState,
  }) async {
    Map<String, dynamic> query = {
      "pageNumber": 0,
      "pageSize": 10,
      'search': null
    };

    try {
      setState(() {
        isLoding = true;
      });
      await authservice
          .getCategoryListApi(
              query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          categoryListModel = value;
          isLoding = false;
          notifyListeners();
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future<void> getBrandList({
    required BuildContext context,
    required setState,
  }) async {
    Map<String, dynamic> query = {"pageNumber": -1, "pageSize": -1};

    try {
      setState(() {
        isLoding = true;
      });
      await authservice
          .getBrandListApi(query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            brandListModel = value;
            isLoding = false;
          });
          notifyListeners();
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future<void> getTopProduct({
    required BuildContext context,
    required setState,
  }) async {
    try {
      setState(() {
        isLoding = true;
      });
      await authservice
          .getTopProductApi(context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            getTopProductModel = value;
            isLoding = false;
            notifyListeners();
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future<void> getLocation({
    required BuildContext context,
    required setState,
  }) async {
    try {
      setState(() {
        isLoding = true;
      });
      await authservice
          .getLocationApi(context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            locationModel = value;

            isLoding = false;
            notifyListeners();
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }
}
