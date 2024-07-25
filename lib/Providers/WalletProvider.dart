import 'package:e_basket/models/AddMoneyModel.dart';
import 'package:e_basket/models/GetBillingDeatilsModel.dart';
import 'package:e_basket/models/GetBillingModel.dart';
import 'package:e_basket/models/GetWalletModel.dart';
import 'package:e_basket/models/RechargeHistoryModel.dart';
import 'package:e_basket/models/VerifyWalletModel.dart';
import 'package:e_basket/services/WalletService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Walletprovider with ChangeNotifier {
  Walletservice walletservice = Walletservice();
  GetWalletModel? getWalletModel;
  RechargeHistoryModel? rechargeHistoryModel;
  GetBillingListModel? getBillingListModel;
  GetBillingDetailModel? getBillingDetailModel;
  String selectedItem1 = '';

  String get selectedItem => selectedItem1;

  set selectedItem(String value) {
    selectedItem1 = value;
    print({'jhjkhj': selectedItem1});
    notifyListeners();
  }

  bool isLoding = false;
  Future<void> getWallet({
    required BuildContext context,
    required setState,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> query = {
      'userId': getid,
    };
    print({'query of subcategory id': query});
    try {
      setState(() {
        isLoding = true;
      });
      await walletservice
          .getWalletApi(query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            getWalletModel = value;
            notifyListeners();
            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future<AddMoneyModel?> addWalletMoney({
    required BuildContext context,
    required setState,
    required amount,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> body = {"userId": getid, "amount": amount};
    print({'query of subcategory id': body});
    try {
      setState(() {
        isLoding = true;
      });
      var resp = await walletservice.addWalletApi(
          body: body, context: context, setState: setState);
      return resp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<VerifyWalletModel?> verifyWalletMoney(
      {required BuildContext context,
      required setState,
      required razorpayId,
      required paymentId,
      required razorpaySignature}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> body = {
      "userId": getid.toString(),
      "razorpayId": razorpayId,
      "paymentId": paymentId,
      "razorpaySignature": razorpaySignature
    };
    print({'query of subcategory id': body});
    try {
      setState(() {
        isLoding = true;
      });
      var resp = await walletservice.verifyWalletApi(
          body: body, context: context, setState: setState);
      return resp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<void> geRechargeHistory({
    required BuildContext context,
    required setState,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> query = {
      'userId': getid,
    };
    print({'query of subcategory id': query});
    try {
      setState(() {
        isLoding = true;
      });
      await walletservice
          .getRechargeHistoryApi(
              query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            rechargeHistoryModel = value;
            notifyListeners();
            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future<void> getBillingHistory(
      {required BuildContext context,
      required setState,
      required startDate,
      required endDate}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> query = {
      'startDateStr': startDate,
      'endDateStr': endDate,
      'userId': getid
    };
    print({'query of getBilling': query});
    try {
      setState(() {
        isLoding = true;
      });
      await walletservice
          .getBillingHistoryApi(
              query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          if ((value?.data ?? []).isEmpty) {
            Fluttertoast.showToast(msg: 'No billing history found');
          } else {
            setState(() {
              getBillingListModel = value;
              notifyListeners();
              isLoding = false;
            });
          }
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future<void> getBillingDetails(
      {required BuildContext context,
      required setState,
      required billingId,
      required orderId,
      required subscriptionId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> query = {
      'userId': getid,
      'billingId': billingId,
      'orderId': orderId,
      'subscriptionId': subscriptionId
    };
    print({'query of getBillingDetails': query});
    try {
      setState(() {
        isLoding = true;
      });
      await walletservice
          .getBillingDetailsApi(
              query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            getBillingDetailModel = value;
            notifyListeners();
            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }
}
