import 'package:e_basket/models/CartProductListModel.dart';
import 'package:e_basket/models/FilterListModel.dart';

import 'package:e_basket/models/MyOrderListModel.dart';
import 'package:e_basket/models/ProductListByCategoryIdModel.dart';
import 'package:e_basket/models/SearchProductListModel.dart';
import 'package:e_basket/models/SubcategoryModel.dart';
import 'package:e_basket/models/UpdateProductListModel.dart';

import 'package:e_basket/services/CartManagementService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cartmanagementprovider with ChangeNotifier {
  Cartmanagementservice cartmanagementservice = Cartmanagementservice();
  ProductListByCategoryIdModel? productListByCategoryId;
  SubCategoryModel? subCategoryModel;
  CartProductListModel? cartProductListModel;
  // CartResponseList?cartResponseList;
  UpdateProductListModel? updateProductListModel;
  SearchProductListModel? searchProductListModel;

  MyOrderListModel? myOrderListModel;
  FilterListModel? filterListModel;
  List<int> selectedItem1 = [];

  List<int> get selectedItem => selectedItem1;

  set selectedItem(List<int> value) {
    selectedItem1 = value;
    print({'jhjkhj': selectedItem1});
    notifyListeners();
  }

  List<int> isSelectedCategory = [];
  List<int> isSelectedBrand = [];
  List<Map<String, dynamic>> isSelectedPrice = [];
  var isLoding = false;
  Future<ProductListByCategoryIdModel?> getProductList(
      {required BuildContext context,
      required setState,
      required currentPage,
      required pageSize,
      required categoryId,
      subCategoryId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> query = {
      "page": currentPage,
      "size": pageSize,
      'categoryId': categoryId,
      'subcategoryId': subCategoryId,
      'userId': getid
    };
    print({'query of product list': query});
    try {
      setState(() {
        isLoding = true;
      });
      await cartmanagementservice
          .getProductListApi(query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            productListByCategoryId = value;

            notifyListeners();
            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<void> getSubCategoryList({
    required BuildContext context,
    required setState,
    required categoryId,
  }) async {
    Map<String, dynamic> query = {
      'categoryId': categoryId,
    };
    print({'query of subcategory id': query});
    try {
      setState(() {
        isLoding = true;
      });
      await cartmanagementservice
          .getSubCategoryListApi(
              query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            subCategoryModel = value;
            isLoding = false;
            notifyListeners();
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future<void> getCartProductList({
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
      await cartmanagementservice
          .getCartProductListApi(
              query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            cartProductListModel = value;
            notifyListeners();
            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future addToCart({
    required BuildContext context,
    required setState,
    required productId,
    required quentity,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> body = {
      "productId": productId,
      "userId": getid,
      "quantity": quentity
    };
    print({'query of subcategory id': body});
    try {
      setState(() {
        isLoding = true;
      });
      await cartmanagementservice
          .addtoCartApi(body: body, context: context, setState: setState)
          .then((onValue) {
        if (onValue == true) {
          setState(() {
            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future updateCartProductList({
    required BuildContext context,
    required setState,
    required productId,
    required quentity,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> body = {
      "productId": productId,
      "userId": getid,
      "quantity": quentity
    };
    print({'query of subcategory id': body});
    try {
      setState(() {
        isLoding = true;
      });
      await cartmanagementservice
          .updateCartProductListApi(
              body: body, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            updateProductListModel = value;
            notifyListeners();

            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future<SearchProductListModel?> searchProductList({
    required BuildContext context,
    required setState,
    required searchText,
    required currentPage,
    required pageSize,
  }) async {
    Map<String, dynamic> query = {
      "page": currentPage,
      "size": pageSize,
      'isDeleted': null,
      'searchText': searchText,
      'filterByQuantity': '',
    };
    print({'query of product list': query});
    try {
      setState(() {
        isLoding = true;
      });
      var searchResp = await cartmanagementservice.searchtProductListApi(
          query: query, context: context, setState: setState);
      return searchResp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<bool?> placeOrder({
    required BuildContext context,
    required setState,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> query = {
      "userId": getid,
    };
    print({'query of subcategory id': query});
    try {
      setState(() {
        isLoding = true;
      });
      var resp = await cartmanagementservice.placeOrderApi(
          query: query, context: context, setState: setState);
      return resp;
    } catch (e) {
      print({'object': e});
    }
    return null;
  }

  Future<void> getMyoredrList(
      {required BuildContext context,
      required setState,
      required selectedDate}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');
    Map<String, dynamic> query = {
      'date': selectedDate,
      'userId': getid,
    };
    print({'query of subcategory id': query});
    try {
      setState(() {
        isLoding = true;
      });
      await cartmanagementservice
          .getMyOrderListApi(query: query, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            myOrderListModel = value;
            notifyListeners();
            isLoding = false;
          });
        }
      });
    } catch (e) {
      print({'object': e});
    }
  }

  Future<FilterListModel?> filterByRefine(
      {required BuildContext context,
      required setState,
      required categoryIds,
      required brandsId,
      required priceRanges}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getid = pref.getInt('userId');

    Map<String, dynamic> body = {
      'categoryIds': categoryIds,
      'brandsId': brandsId,
      'priceRanges': priceRanges,
      'userId': getid,
    };
    print({'body of filter': body});
    try {
      setState(() {
        isLoding = true;
      });
      await cartmanagementservice
          .filterByrefineApi(body: body, context: context, setState: setState)
          .then((value) {
        if (value?.status?.httpCode == '200') {
          setState(() {
            filterListModel = value;
            notifyListeners();
          });
          isLoding = false;
        }
      });
    } catch (e) {
      print({'object': e});
    }
    return null;
  }
}
