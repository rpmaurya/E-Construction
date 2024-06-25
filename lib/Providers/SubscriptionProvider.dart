import 'package:e_basket/models/AddSubscriptionModel.dart';
import 'package:e_basket/models/DeleteSubscriptionModel.dart';
import 'package:e_basket/models/GetSubscriptionModel.dart';
import 'package:e_basket/models/ProductSubscriptionModel.dart';
import 'package:e_basket/models/ResumeSubscriptionModel.dart';
import 'package:e_basket/models/UpdateSubscriptionModel.dart';
import 'package:e_basket/services/SubscriptionService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Subscriptionprovider with ChangeNotifier {
  Subscriptionservice subscriptionservice = Subscriptionservice();
  ProductSubscriptionModel? productSubscriptionModel;
  UpdateSubscriptionModel? updateSubscriptionModel;
  AddSubscriptionModel? addSubscriptionModel;
  GetSubscriptionModel? getSubscriptionModel;
  bool isLoding = false;
  Future<ProductSubscriptionModel?> addProductSubscription(
      {required BuildContext context,
      required setState,
      required productId,
      required quentity}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> body = {
      "userId": getid,
      "productId": productId,
      "quantity": quentity
    };
    print({'getid...': body});
    try {
      setState(() {
        isLoding = true;
      });
      var resp = await subscriptionservice.addProductSubscriptionApi(
          body: body, context: context, setState: setState);
      setState(() {
        isLoding = false;
        notifyListeners();
      });
      return resp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<UpdateSubscriptionModel?> updateSubscription({
    required BuildContext context,
    required setState,
    required subscriptionId,
    required quentity,
  }) async {
    Map<String, dynamic> body = {
      "subscriptionId": subscriptionId,
      "quantity": quentity
    };
    print({'query of subcategory id': body});
    try {
      setState(() {
        isLoding = true;
      });
      var resp = await subscriptionservice.updateSubscritionApi(
          body: body, context: context, setState: setState, temorary: false);
      setState(() {
        isLoding = false;
        notifyListeners();
      });
      return resp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<ResumeSubscriptionModel?> resumeSubscription({
    required BuildContext context,
    required setState,
    required subscriptionId,
  }) async {
    Map<String, dynamic> body = {
      "subscriptionId": subscriptionId,
    };
    print({'query of subcategory id': body});
    try {
      setState(() {
        isLoding = true;
      });
      var resp = await subscriptionservice.resumeSubscritionApi(
          body: body, context: context, setState: setState);
      setState(() {
        isLoding = false;
        notifyListeners();
      });
      return resp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<DeleteSubscriptionModel?> deleteSubscription(
      {required BuildContext context,
      required setState,
      required subscriptionId,
      required reason}) async {
    Map<String, dynamic> query = {
      "subscriptionId": subscriptionId,
      "reason": reason
    };
    print({'query of subcategory id': query});
    try {
      setState(() {
        isLoding = true;
      });
      var resp = await subscriptionservice.deleteSubscritionApi(
          query: query, context: context, setState: setState);
      setState(() {
        isLoding = false;
        notifyListeners();
      });
      return resp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<DeleteSubscriptionModel?> pauseSubscription(
      {required BuildContext context,
      required setState,
      required subscriptionId,
      required startDate,
      required pauseDate}) async {
    Map<String, dynamic> body = {
      "subscriptionId": subscriptionId,
      "startDate": startDate,
      "pauseDate": pauseDate,
    };
    print({'query of subcategory id': body});
    try {
      setState(() {
        isLoding = true;
      });
      var resp = await subscriptionservice.pauseSubscritionApi(
          body: body, context: context, setState: setState);
      setState(() {
        isLoding = false;
        notifyListeners();
      });
      return resp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<UpdateSubscriptionModel?> updateSubscriptionTemorary({
    required BuildContext context,
    required setState,
    required subscriptionId,
    required startDate,
    required pauseDate,
    required quentity,
  }) async {
    Map<String, dynamic> body = {
      "subscriptionId": subscriptionId,
      "startDate": startDate,
      "pauseDate": pauseDate,
      "quantity": quentity
    };
    print({'query of subcategory id': body});
    try {
      setState(() {
        isLoding = true;
      });
      var resp = await subscriptionservice.updateSubscritionApi(
          body: body, context: context, setState: setState, temorary: true);
      setState(() {
        isLoding = false;
        notifyListeners();
      });
      return resp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<AddSubscriptionModel?> addSubscription(
      {required BuildContext context,
      required setState,
      required subscriptionId,
      required quentity,
      required subscriptionType,
      required startDate,
      required selectedDaysOfWeek,
      required selectedDates}) async {
    Map<String, dynamic> body = {
      "subscriptionId": subscriptionId,
      "quantity": quentity,
      'subscriptionType': subscriptionType,
      'startDate': startDate,
      'selectedDaysOfWeek': selectedDaysOfWeek,
      'selectedDates': selectedDates
    };
    print({'query of subcategory id': body});
    try {
      setState(() {
        isLoding = true;
      });
      var resp = await subscriptionservice.addSubscritionApi(
          body: body, context: context, setState: setState);
      setState(() {
        isLoding = false;
        notifyListeners();
      });
      return resp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<void> getSubscription({
    required BuildContext context,
    required setState,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> query = {
      "userId": getid,
      "page": 0,
      'size': 20,
    };
    print({'query of subcategory id': query});
    try {
      setState(() {
        isLoding = true;
      });
      await subscriptionservice
          .getSubscritionApi(query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            getSubscriptionModel = value;
            isLoding = false;
            notifyListeners();
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
    return null;
  }
}
