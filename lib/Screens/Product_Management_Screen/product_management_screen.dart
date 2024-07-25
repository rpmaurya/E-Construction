import 'package:e_basket/Providers/CartManagementProvider.dart';
import 'package:e_basket/Providers/SubscriptionProvider.dart';
import 'package:e_basket/Screens/Product_Management_Screen/filter_screen.dart';
import 'package:e_basket/Screens/Product_Management_Screen/placeOrder_screen.dart';
import 'package:e_basket/Screens/Subscription_Management_Screen/Subscribe_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:e_basket/models/CartProductListModel.dart';
import 'package:e_basket/models/ProductListByCategoryIdModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductManagementScreen extends StatefulWidget {
  final int categoryId;
  final String? titleName;
  final int? subCategoryId;
  final bool visible;
  const ProductManagementScreen(
      {super.key,
      required this.categoryId,
      this.titleName,
      required this.subCategoryId,
      required this.visible});

  @override
  State<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  Cartmanagementprovider cartmanagementprovider = Cartmanagementprovider();
  int quantity = 0;
  String? title;
  // List dataList = [];
  List<ProductListByCategoryId> dataList = [];
  int currentPage = 0;
  bool lastPage = false;
  bool isLoading = false;
  final int itemsPerPage = 10;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.titleName;
    fetchItems();
    _scrollController.addListener(() {
      // fetchItems();
      setState(() {
        print('object/////..../././././');
      });
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent
          // _scrollController.offset >=
          //         _scrollController.position.maxScrollExtent &&
          //     !_scrollController.position.outOfRange

          ) {
        print('object......./////');
        if (!isLoading && !lastPage) {
          fetchItems();
        }
      }
    });
    cartmanagementprovider.getSubCategoryList(
        context: context, setState: setState, categoryId: widget.categoryId);
    cartmanagementprovider.getCartProductList(
        context: context, setState: setState);
  }

  Future<void> fetchItems() async {
    if (isLoading || lastPage) return;
    setState(() {
      isLoading = true;
    });
    cartmanagementprovider.getProductList(
        context: context,
        setState: setState,
        currentPage: currentPage,
        pageSize: itemsPerPage,
        categoryId: widget.categoryId,
        subCategoryId: widget.subCategoryId);
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    // List<int> newItems = List.generate(
    //     itemsPerPage, (index) => (currentPage) * itemsPerPage + index + 1);
    // print('newvalue$newItems');

    var newData = cartmanagementprovider.productListByCategoryId?.data;

    setState(() {
      if ((newData ?? []).length < itemsPerPage) {
        lastPage = true;
      }
      dataList.addAll(newData ?? []);
      currentPage++;
      // lastPage = (newData ?? []).length < 2;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print({'category id ': widget.categoryId});
    Subscriptionprovider subscriptionprovider =
        Provider.of(context, listen: false);
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  expandedHeight: widget.visible == true &&
                          (cartmanagementprovider.subCategoryModel?.data ?? [])
                              .isNotEmpty
                      ? 180.0
                      : 110.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1.1,
                    titlePadding: EdgeInsets.only(top: 5),
                    background: Column(
                      children: [
                        AppBar(
                          centerTitle: true,
                          title: Text(title ?? ''),
                          actions: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.search))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        widget.visible == true
                            ? SizedBox(
                                height: 55,
                                child: ListView.builder(
                                    // physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cartmanagementprovider
                                            .subCategoryModel?.data?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      var getdata = cartmanagementprovider
                                          .subCategoryModel?.data;
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            //   cartmanagementprovider.getProductList(context: context, setState: setState, categoryId: widget.categoryId,subCategoryId: getdata?[index].subCategoryId).then((value){

                                            //   setState(() {

                                            //  title=getdata?[index].subCategoryName;

                                            //  });

                                            // });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductManagementScreen(
                                                          categoryId:
                                                              widget.categoryId,
                                                          subCategoryId:
                                                              getdata?[index]
                                                                  .subCategoryId,
                                                          titleName: getdata?[
                                                                  index]
                                                              .subCategoryName,
                                                          visible: false,
                                                        )));
                                          },
                                          child: Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 150),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: ColorConstant()
                                                        .containerColor)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text(
                                                getdata?[index]
                                                        .subCategoryName ??
                                                    'data',
                                                textAlign: TextAlign.center,
                                              )),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : Container()
                      ],
                    ),
                    title: Container(
                      color: Colors.grey[300],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${dataList.length} items',
                              style: TextConstant().subtitleText,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FilterScreen(
                                              getData: cartmanagementprovider
                                                  .subCategoryModel,
                                              categoryId: widget.categoryId,
                                              subCategoryId:
                                                  widget.subCategoryId,
                                              navigatioOf: false,
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black87),
                                    color: Colors.white),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/filter_icon.png',
                                        width: 26,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Filter',
                                        style: TextConstant().filterText,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
            ];
          },
          body: dataList.isEmpty
              ? Container(
                  child: Center(
                    child: Text('No Data Found'),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          // controller: _scrollController,
                          physics: PageScrollPhysics(),
                          itemCount:
                              dataList.length + (isLoading || lastPage ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == dataList.length) {
                              if (lastPage) {
                                return Container(
                                  height: 50,
                                  color: Colors.grey[350],
                                  margin: EdgeInsets.only(bottom: 60),
                                  child:
                                      Center(child: Text("That's all folk!")),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }
                            var getdat = dataList;
                            // var getdat = items[index];

                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Container(
                                height: 230,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorConstant().containerColor)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.network(
                                                  '${getdat[index].productImageUrl ?? 'https://5.imimg.com/data5/CT/IY/XK/GLADMIN-12/jcbe1.jpeg'}',
                                                  width: 150,
                                                  height: 150,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              child: Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  getdat[index].productName ??
                                                      '',
                                                  style: TextConstant()
                                                      .cardtitleText,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  getdat[index]
                                                          .productDescription ??
                                                      '',
                                                  style: TextConstant()
                                                      .cardtitleText,
                                                ),
                                                const SizedBox(
                                                  height: 60,
                                                ),
                                                Text(
                                                  '\u20B9${getdat[index].price}',
                                                  style:
                                                      TextConstant().titleText,
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          cartmanagementprovider
                                                          .cartProductListModel
                                                          ?.data ==
                                                      null ||
                                                  getdat[index]
                                                          .userSelectedQuantity ==
                                                      0
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      quantity = getdat[index]
                                                              .userSelectedQuantity ??
                                                          0;
                                                    });
                                                    cartmanagementprovider
                                                        .addToCart(
                                                            context: context,
                                                            setState: setState,
                                                            productId:
                                                                cartmanagementprovider
                                                                    .productListByCategoryId
                                                                    ?.data?[
                                                                        index]
                                                                    .id,
                                                            quentity:
                                                                ++quantity)
                                                        .then((value) {
                                                      setState(() {
                                                        cartmanagementprovider
                                                            .getProductList(
                                                                context:
                                                                    context,
                                                                setState:
                                                                    setState,
                                                                currentPage:
                                                                    currentPage,
                                                                pageSize:
                                                                    itemsPerPage,
                                                                categoryId: widget
                                                                    .categoryId,
                                                                subCategoryId:
                                                                    widget
                                                                        .subCategoryId);
                                                        cartmanagementprovider
                                                            .getCartProductList(
                                                                context:
                                                                    context,
                                                                setState:
                                                                    setState);
                                                      });
                                                    });
                                                  },
                                                  child: Container(
                                                      width: 130,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black87),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: const Center(
                                                          child: Text(
                                                        'Buy Once',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ))),
                                                )
                                              : Container(
                                                  width: 130,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.pink),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  child: Center(
                                                    child: Row(
                                                      // mainAxisSize: MainAxisSize.max,
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                            child:
                                                                GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              quantity = getdat[
                                                                          index]
                                                                      .userSelectedQuantity ??
                                                                  0;
                                                            });
                                                            cartmanagementprovider
                                                                .updateCartProductList(
                                                                    context:
                                                                        context,
                                                                    setState:
                                                                        setState,
                                                                    productId: cartmanagementprovider
                                                                        .productListByCategoryId
                                                                        ?.data?[
                                                                            index]
                                                                        .id,
                                                                    quentity:
                                                                        --quantity)
                                                                .then((value) {
                                                              setState(() {
                                                                cartmanagementprovider.getProductList(
                                                                    context:
                                                                        context,
                                                                    setState:
                                                                        setState,
                                                                    currentPage:
                                                                        currentPage,
                                                                    pageSize:
                                                                        itemsPerPage,
                                                                    categoryId:
                                                                        widget
                                                                            .categoryId,
                                                                    subCategoryId:
                                                                        widget
                                                                            .subCategoryId);
                                                                cartmanagementprovider
                                                                    .getCartProductList(
                                                                        context:
                                                                            context,
                                                                        setState:
                                                                            setState);
                                                              });
                                                            });
                                                          },
                                                          child: const Center(
                                                              child: Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .pink)),
                                                        )),
                                                        Divider(),
                                                        Expanded(
                                                          child: Container(
                                                              color:
                                                                  Colors.pink,
                                                              child: Center(
                                                                  child: Text(
                                                                '${getdat[index].userSelectedQuantity ?? 0}',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ))),
                                                        ),
                                                        Divider(),
                                                        Expanded(
                                                            child:
                                                                GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              quantity = getdat[
                                                                          index]
                                                                      .userSelectedQuantity ??
                                                                  0;
                                                            });
                                                            cartmanagementprovider
                                                                .updateCartProductList(
                                                                    context:
                                                                        context,
                                                                    setState:
                                                                        setState,
                                                                    productId: cartmanagementprovider
                                                                        .productListByCategoryId
                                                                        ?.data?[
                                                                            index]
                                                                        .id,
                                                                    quentity:
                                                                        ++quantity)
                                                                .then((value) {
                                                              cartmanagementprovider.getProductList(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  currentPage:
                                                                      currentPage,
                                                                  pageSize:
                                                                      itemsPerPage,
                                                                  categoryId: widget
                                                                      .categoryId,
                                                                  subCategoryId:
                                                                      widget
                                                                          .subCategoryId);
                                                              cartmanagementprovider
                                                                  .getCartProductList(
                                                                      context:
                                                                          context,
                                                                      setState:
                                                                          setState);
                                                              setState(() {});
                                                            });
                                                          },
                                                          child: const Center(
                                                              child: Icon(
                                                            Icons.add,
                                                            color: Colors.pink,
                                                          )),
                                                        ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                subscriptionprovider
                                                    .addProductSubscription(
                                                        context: context,
                                                        setState: setState,
                                                        productId:
                                                            getdat[index].id,
                                                        quentity: quantity + 1)
                                                    .then((value) {
                                                  if (value?.status?.httpCode ==
                                                      '200') {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SubscribeScreen(
                                                                    getdata:
                                                                        value)));
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: 210,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.pink[600],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: const Center(
                                                    child: Text(
                                                  'Subscibe @ \u20B922',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    if (isLoading)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: cartmanagementprovider.cartProductListModel?.data ==
              null
          ? Container()
          : Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        color: Colors.white,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/cart_icon.png',
                              height: 24,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '\u20B9 ${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.totalPrice}',
                                  style: TextConstant().cardtitleText,
                                ),
                                Text(
                                  '${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.totalQuantity} item',
                                  style: TextConstant().subtitleText,
                                )
                              ],
                            )
                          ],
                        ))),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlaceorderScreen()))
                            .then((value) {
                          setState(() {
                            cartmanagementprovider.getProductList(
                                context: context,
                                setState: setState,
                                currentPage: currentPage,
                                pageSize: itemsPerPage,
                                categoryId: widget.categoryId);
                            cartmanagementprovider.getCartProductList(
                                context: context, setState: setState);
                          });
                        });
                      },
                      child: Container(
                          color: Colors.pink,
                          child: const Center(
                              child: Text(
                            'View Cart',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ))),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  // cartbutton(int item) {
  //   return Container(
  //     width: 130,
  //     height: 30,
  //     decoration: BoxDecoration(
  //         border: Border.all(color: Colors.pink),
  //         borderRadius: BorderRadius.circular(25)),
  //     child: Center(
  //       child: Row(
  //         // mainAxisSize: MainAxisSize.max,
  //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Expanded(
  //               child: Center(child: Icon(Icons.remove, color: Colors.pink))),
  //           Divider(),
  //           Expanded(
  //             child: Container(
  //                 color: Colors.pink,
  //                 child: Center(
  //                     child: Text(
  //                   '${item}',
  //                   style: TextStyle(
  //                       color: Colors.white, fontWeight: FontWeight.w700),
  //                 ))),
  //           ),
  //           Divider(),
  //           Expanded(
  //               child: Center(
  //                   child: Icon(
  //             Icons.add,
  //             color: Colors.pink,
  //           )))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
