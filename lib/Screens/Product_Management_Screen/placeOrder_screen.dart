import 'package:e_basket/Providers/CartManagementProvider.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';

class PlaceorderScreen extends StatefulWidget {
  const PlaceorderScreen({super.key});

  @override
  State<PlaceorderScreen> createState() => _PlaceorderScreenState();
}

class _PlaceorderScreenState extends State<PlaceorderScreen> {
  Cartmanagementprovider cartmanagementprovider = Cartmanagementprovider();
  int quantity = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartmanagementprovider.getCartProductList(
        context: context, setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context,true);
        }, icon: Icon(Icons.arrow_back)),
        title: Text('E-Construction'),
        centerTitle: true,
      ),
      body: Expanded(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: []..addAll([
                    ...cartmanagementprovider
                            .cartProductListModel?.data?.cartResponseList ??
                        []
                  ].map((getdata) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      '${getdata.imageurl ?? 'https://5.imimg.com/data5/CT/IY/XK/GLADMIN-12/jcbe1.jpeg'}',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(getdata.productName ?? ''),
                                    Text(getdata.productName ?? ''),
                                    Text('\u20B9 ${getdata.price ?? 0.0}')
                                  ],
                                ),
                              ),
                              Container(
                                width: 110,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.pink),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.max,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: GestureDetector(
                                        onTap: () {
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
                                              cartmanagementprovider
                                                  .getCartProductList(
                                                      context: context,
                                                      setState: setState);
                                            });
                                          });
                                        },
                                        child: Center(
                                            child: Icon(Icons.remove,
                                                color: Colors.pink)),
                                      )),
                                      Divider(),
                                      Expanded(
                                        child: Container(
                                            color: Colors.pink,
                                            child: Center(
                                                child: Text(
                                              '${getdata.quantity}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ))),
                                      ),
                                      Divider(),
                                      Expanded(
                                          child: GestureDetector(
                                        onTap: () {
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
                                            cartmanagementprovider
                                                .getCartProductList(
                                                    context: context,
                                                    setState: setState);
                                            setState(() {});
                                          });
                                        },
                                        child: Center(
                                            child: Icon(
                                          Icons.add,
                                          color: Colors.pink,
                                        )),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    );
                  })),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Summary'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sub Total:'),
                          Text(
                              '${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.price ?? 0.0}')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery Charge:'),
                          Text(
                              '${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.deliveryCharge ?? 0}')
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:'),
                          Text(
                              '${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.totalPrice ?? 0}')
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
                child: ListTile(
                  leading: Icon(Icons.calendar_month),
                  title: Text('Delivery on'),
                  subtitle: Text(
                      '${cartmanagementprovider.cartProductListModel?.data?.orderSummary?.deliveryDate}'),
                ),
              ),
            ),
            SizedBox(height: 150,)
          ],
        ),
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
                      subtitle: Text('sector 62 noida up'),
                      trailing: Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                  Divider(),
                  Container(
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
