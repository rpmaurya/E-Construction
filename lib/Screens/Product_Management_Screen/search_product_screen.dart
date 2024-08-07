import 'package:e_basket/Providers/CartManagementProvider.dart';
import 'package:e_basket/Screens/Product_Management_Screen/filter_screen.dart';
import 'package:e_basket/Screens/Product_Management_Screen/placeOrder_screen.dart';
import 'package:e_basket/Screens/Product_Management_Screen/product_management_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:e_basket/models/SearchProductListModel.dart';
import 'package:flutter/material.dart';

class SearchProductScreen extends StatefulWidget {
  final String? searchText;
  final bool visible;
  const SearchProductScreen(
      {super.key, required this.searchText, required this.visible});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  Cartmanagementprovider cartmanagementprovider = Cartmanagementprovider();

  int quantity = 0;
  List<Content> dataList = [];
  SearchProductListModel? searchProductListModel;
  int currentPage = 0;
  bool lastPage = false;
  bool isLoading = false;
  final int itemsPerPage = 10;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    cartmanagementprovider.getCartProductList(
        context: context, setState: setState);
  }

  Future<void> fetchItems() async {
    if (isLoading || lastPage) return;
    setState(() {
      isLoading = true;
    });

    cartmanagementprovider
        .searchProductList(
            context: context,
            setState: setState,
            searchText: widget.searchText,
            currentPage: currentPage,
            pageSize: itemsPerPage)
        .then((onValue) {
      if (onValue?.status?.httpCode == '200') {
        setState(() {
          searchProductListModel = onValue;
        });
      }
    });
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    // List<int> newItems = List.generate(
    //     itemsPerPage, (index) => (currentPage) * itemsPerPage + index + 1);
    // print('newvalue$newItems');

    var newData = searchProductListModel?.data?.content;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                expandedHeight: 100.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.1,
                  titlePadding: EdgeInsets.only(top: 5),
                  background: Column(
                    children: [
                      AppBar(
                        centerTitle: true,
                        title: Text('Go build'),
                        actions: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.search))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.visible == true
                          ? SizedBox(
                              height: 55,
                              child: ListView.builder(
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

                                          //    title=getdata?[index].subCategoryName;

                                          //  });

                                          // });
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductManagementScreen(
                                                        categoryId: 0,
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(
                                              getdata?[index].subCategoryName ??
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
                                            navigatioOf: true,
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
                ),
              )
            ];
          },
          body: Container(
            color: Colors.white70,
            child: dataList.isEmpty
                ? const Center(
                    child: Text('No Data Found'),
                  )
                : ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount:
                        dataList.length + (isLoading || lastPage ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == dataList.length) {
                        if (lastPage) {
                          return Container(
                            height: 50,
                            color: Colors.grey[350],
                            margin: EdgeInsets.only(bottom: 60),
                            child: Center(child: Text("That's all folk!")),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                      var getdat = dataList;

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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black12),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            getdat[index].productImageUrl ??
                                                'https://tse4.mm.bing.net/th?id=OIP.8vtlhiG0ozEzXbDlax-91gAAAA&pid=Api&P=0&h=220',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          getdat[index].productName ?? '',
                                          style: TextConstant().cardtitleText,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          getdat[index].brandName ?? '',
                                          style: TextConstant().cardtitleText,
                                        ),
                                        const SizedBox(
                                          height: 60,
                                        ),
                                        Text(
                                          '\u20B9${getdat[index].price}',
                                          style: TextConstant().titleText,
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    cartmanagementprovider.cartProductListModel
                                                    ?.data ==
                                                null ||
                                            getdat[index]
                                                    .userSelectedquantity ==
                                                null
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                quantity = getdat[index]
                                                        .userSelectedquantity ??
                                                    0;
                                              });
                                              cartmanagementprovider
                                                  .addToCart(
                                                      context: context,
                                                      setState: setState,
                                                      productId:
                                                          cartmanagementprovider
                                                              .productListByCategoryId
                                                              ?.data?[index]
                                                              .id,
                                                      quentity: ++quantity)
                                                  .then((value) {
                                                setState(() {
                                                  // cartmanagementprovider
                                                  //     .getProductList(
                                                  //         context: context,
                                                  //         setState: setState,
                                                  //         categoryId: 0,
                                                  //         subCategoryId: 0);
                                                  cartmanagementprovider
                                                      .getCartProductList(
                                                          context: context,
                                                          setState: setState);
                                                });
                                              });
                                            },
                                            child: Container(
                                                width: 130,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black87),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: const Center(
                                                    child: Text(
                                                  'Buy Once',
                                                  textAlign: TextAlign.center,
                                                ))),
                                          )
                                        : Container(
                                            width: 130,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.pink),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Center(
                                              child: Row(
                                                // mainAxisSize: MainAxisSize.max,
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        quantity = getdat[index]
                                                                .userSelectedquantity ??
                                                            0;
                                                      });
                                                      cartmanagementprovider
                                                          .updateCartProductList(
                                                              context: context,
                                                              setState:
                                                                  setState,
                                                              productId:
                                                                  cartmanagementprovider
                                                                      .productListByCategoryId
                                                                      ?.data?[
                                                                          index]
                                                                      .id,
                                                              quentity:
                                                                  --quantity)
                                                          .then((value) {
                                                        setState(() {
                                                          // cartmanagementprovider
                                                          //     .getProductList(
                                                          //         context:
                                                          //             context,
                                                          //         setState:
                                                          //             setState,
                                                          //         categoryId: 0,
                                                          //         subCategoryId:
                                                          //             0);
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
                                                            color:
                                                                Colors.pink)),
                                                  )),
                                                  const Divider(),
                                                  Expanded(
                                                    child: Container(
                                                        color: Colors.pink,
                                                        child: Center(
                                                            child: Text(
                                                          '${getdat[index].userSelectedquantity ?? 0}',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ))),
                                                  ),
                                                  const Divider(),
                                                  Expanded(
                                                      child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        quantity = getdat[index]
                                                                .userSelectedquantity ??
                                                            0;
                                                      });
                                                      cartmanagementprovider
                                                          .updateCartProductList(
                                                              context: context,
                                                              setState:
                                                                  setState,
                                                              productId:
                                                                  cartmanagementprovider
                                                                      .productListByCategoryId
                                                                      ?.data?[
                                                                          index]
                                                                      .id,
                                                              quentity:
                                                                  ++quantity)
                                                          .then((value) {
                                                        // cartmanagementprovider
                                                        //     .getProductList(
                                                        //         context:
                                                        //             context,
                                                        //         setState:
                                                        //             setState,
                                                        //         categoryId:
                                                        //             widget,
                                                        //         subCategoryId:
                                                        //             widget);
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
                                    // : cartbutton(cartmanagementprovider.cartProductListModel?.data?.cartResponseList![index].quantity??0),
                                    Container(
                                      width: 210,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.pink[600],
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: const Center(
                                          child: Text(
                                        'Subscibe @ \u20B922',
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: cartmanagementprovider.cartProductListModel?.data ==
              null
          ? Container()
          : SizedBox(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 55,
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
                                  builder: (context) =>
                                      const PlaceorderScreen())).then((value) {
                            setState(() {
                              // cartmanagementprovider.getProductList(
                              //     context: context,
                              //     setState: setState,
                              //     categoryId: widget);
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
            ),
    );
  }
}
