import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Providers/CartManagementProvider.dart';
import 'package:e_basket/Screens/Product_Management_Screen/order_successful_screen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/wallet_screen.dart';
import 'package:e_basket/common_file/BuyAndScubscribe_container.dart';
import 'package:e_basket/common_file/common_button.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class PlaceorderScreen extends StatefulWidget {
  const PlaceorderScreen({super.key});

  @override
  State<PlaceorderScreen> createState() => _PlaceorderScreenState();
}

class _PlaceorderScreenState extends State<PlaceorderScreen> {
  Cartmanagementprovider cartmanagementprovider = Cartmanagementprovider();
  AuthProvider authProvider = AuthProvider();
  int quantity = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartmanagementprovider.getCartProductList(
        context: context, setState: setState);
    authProvider.getUserById(context: context, setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          'E-Construction',
          style: TextConstant().cardTitle,
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete_sweep))],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 8,
          ),
          Column(
            children: []..addAll([
                ...cartmanagementprovider
                        .cartProductListModel?.data?.cartResponseList ??
                    []
              ].map((getdata) {
                return Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.only(
                    //       left: 10, right: 10, top: 5, bottom: 5),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: Colors.black12),
                    //             borderRadius: BorderRadius.circular(5)),
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(2.0),
                    //           child: ClipRRect(
                    //             borderRadius: BorderRadius.circular(5),
                    //             child: Image.network(
                    //               '${getdata.imageurl ?? 'https://5.imimg.com/data5/CT/IY/XK/GLADMIN-12/jcbe1.jpeg'}',
                    //               width: 100,
                    //               height: 100,
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         width: 10,
                    //       ),
                    //       Expanded(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(getdata.productName ?? ''),
                    //             Text(getdata.productName ?? ''),
                    //             Text('\u20B9 ${getdata.price ?? 0.0}')
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 110,
                    //         height: 30,
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: Colors.pink),
                    //             borderRadius: BorderRadius.circular(5)),
                    //         child: Center(
                    //           child: Row(
                    //             // mainAxisSize: MainAxisSize.max,
                    //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Expanded(
                    //                   child: GestureDetector(
                    //                 onTap: () {
                    //                   setState(() {
                    //                     quantity = getdata.quantity ?? 0;
                    //                   });
                    //                   cartmanagementprovider
                    //                       .updateCartProductList(
                    //                           context: context,
                    //                           setState: setState,
                    //                           productId: getdata.productId,
                    //                           quentity: --quantity)
                    //                       .then((value) {
                    //                     setState(() {
                    //                       cartmanagementprovider
                    //                           .getCartProductList(
                    //                               context: context,
                    //                               setState: setState);
                    //                     });
                    //                   });
                    //                 },
                    //                 child: Center(
                    //                     child: Icon(Icons.remove,
                    //                         color: Colors.pink)),
                    //               )),
                    //               Divider(),
                    //               Expanded(
                    //                 child: Container(
                    //                     color: Colors.pink,
                    //                     child: Center(
                    //                         child: Text(
                    //                       '${getdata.quantity}',
                    //                       style: TextStyle(
                    //                           color: Colors.white,
                    //                           fontWeight: FontWeight.w700),
                    //                     ))),
                    //               ),
                    //               Divider(),
                    //               Expanded(
                    //                   child: GestureDetector(
                    //                 onTap: () {
                    //                   setState(() {
                    //                     quantity = getdata.quantity ?? 0;
                    //                   });
                    //                   cartmanagementprovider
                    //                       .updateCartProductList(
                    //                           context: context,
                    //                           setState: setState,
                    //                           productId: getdata.productId,
                    //                           quentity: ++quantity)
                    //                       .then((value) {
                    //                     cartmanagementprovider
                    //                         .getCartProductList(
                    //                             context: context,
                    //                             setState: setState);
                    //                     setState(() {});
                    //                   });
                    //                 },
                    //                 child: Center(
                    //                     child: Icon(
                    //                   Icons.add,
                    //                   color: Colors.pink,
                    //                 )),
                    //               ))
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    BuyandscubscribeContainer(
                      imageurl: getdata.imageurl ??
                          'https://5.imimg.com/data5/CT/IY/XK/GLADMIN-12/jcbe1.jpeg',
                      titletext: getdata.productName ?? '',
                      subtitletext: getdata.productName ?? '',
                      pricetext: '${getdata.price ?? 0.0}',
                      removeQuentity: () {
                        setState(() {
                          quantity = getdata.quantity ?? 0;
                        });
                        cartmanagementprovider
                            .updateCartProductList(
                                context: context,
                                setState: setState,
                                productId: getdata.productId,
                                quentity: --quantity)
                            .then((value) {
                          setState(() {
                            cartmanagementprovider.getCartProductList(
                                context: context, setState: setState);
                          });
                        });
                      },
                      quentity: getdata.quantity.toString(),
                      addQuentity: () {
                        setState(() {
                          quantity = getdata.quantity ?? 0;
                        });
                        cartmanagementprovider
                            .updateCartProductList(
                                context: context,
                                setState: setState,
                                productId: getdata.productId,
                                quentity: ++quantity)
                            .then((value) {
                          cartmanagementprovider.getCartProductList(
                              context: context, setState: setState);
                          setState(() {});
                        });
                      },
                    ),
                    const Divider(
                      height: 0,
                    )
                  ],
                );
              })),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
              left: 10,
              right: 10,
            ),
            child: Card(
              color: Colors.blueGrey[100],
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 15, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Summary',
                      style: TextConstant().titleText,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total :',
                        ),
                        Text(
                            '\u20B9${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.price ?? 0.0}',
                            style: TextConstant().lableText)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Text('Delivery Charge : '),
                            Icon(
                              Icons.info_outline,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                            '\u20B9${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.deliveryCharge ?? 0}',
                            style: TextConstant().lableText)
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextConstant().titleText,
                        ),
                        Text(
                          '\u20B9${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.totalPrice ?? 0}',
                          style: TextConstant().cardtitleText,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: ListTile(
                leading: const Icon(
                  Icons.calendar_month,
                  size: 30,
                ),
                title: Text(
                  'Delivery on',
                  style: TextConstant().subtitleText,
                ),
                subtitle: Text(
                  // '${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.deliveryDate}',
                  DateFormat.yMMMEd().format(cartmanagementprovider
                          .cartProductListModel
                          ?.data
                          ?.orderSummary
                          ?.deliveryDate ??
                      DateTime.now()),
                  style: TextConstant().lableText,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 150,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: cartmanagementprovider.cartProductListModel?.data ==
              null
          ? Container()
          : Container(
              color: Colors.white,
              height: 150,
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Deliver Address'),
                      subtitle:
                          Text('${authProvider.userModel?.data?.location}'),
                      trailing: Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: Container(
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
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                // showdailog(context);
                                cartmanagementprovider
                                    .placeOrder(
                                        context: context, setState: setState)
                                    .then((value) {
                                  if (value == true) {
                                    Fluttertoast.showToast(
                                        backgroundColor: Colors.green,
                                        msg: 'order successfull');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderSuccessfulScreen()));
                                  } else {
                                    showdailog(context);
                                  }
                                });
                              },
                              child: Container(
                                  color: Colors.pink,
                                  child: Center(
                                      child: Text(
                                    'Place Order',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void showdailog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/wallet.png',
                    scale: 2,
                  ),
                  Text(
                    'Insufficient Balance',
                    style: TextConstant().lableText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Your wallet is low on balance.Kindly recharge to place order',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WalletScreen(
                                    sendOnPage: 'viewCart',
                                  )));
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          gradient: ColorConstant().bottonColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Text(
                          'ADD MONEY',
                          style: TextConstant().buttonText,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
