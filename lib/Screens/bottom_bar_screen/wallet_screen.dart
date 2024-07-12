import 'package:e_basket/Providers/WalletProvider.dart';
import 'package:e_basket/Screens/Wallet_Screen/billing_history_screen.dart';
import 'package:e_basket/Screens/Wallet_Screen/recharge_history_screen.dart';

import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:e_basket/common_file/common_button.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_button/group_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletScreen extends StatefulWidget {
  final String? sendOnPage;
  const WalletScreen({super.key, this.sendOnPage});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  Razorpay _razorpay = Razorpay();

  Walletprovider walletprovider = Walletprovider();
  TextEditingController amountcontroller = TextEditingController();
  // bool? visibleIcon;
  String result = '';
  @override
  void initState() {
    // TODO: implement initState
    walletprovider.getWallet(context: context, setState: setState);

    super.initState();
    _razorpay;
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    amountcontroller.text;
    _razorpay.clear();
  }

  void _addValues(String item1, String item2) {
    final int value1 = int.tryParse(item1) ?? 0;
    final int value2 = int.tryParse(item2) ?? 0;
    setState(() {
      result = '${value1 + value2}';
      print('result $result');
    });
  }

  // int? amount = 1000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              if (widget.sendOnPage == 'mySubscription') {
                Navigator.pop(context);
              } else if (widget.sendOnPage == 'viewCart') {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomBarScreen()),
                  (Route<dynamic> route) => false,
                );
              }
            },
            icon: Icon(Icons.arrow_back)),
        // automaticallyImplyLeading: widget.visible == true ? true : false,
        centerTitle: true,
        title: Text('Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Wallet Balance',
                      style: TextConstant().lableText,
                    ),
                    Text(
                      '\u20B9 ${walletprovider.getWalletModel?.data?.amount ?? 00}',
                      style: TextConstant().cardtitleText,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Balance",
                          style: TextConstant().lableText,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: amountcontroller,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              border: OutlineInputBorder(),
                              hintText: 'Enter Amount'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              result = value;

                              print('object$result');
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Recommend',
                          style: TextConstant().cardtitleText,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GroupButton(
                          buttons: ['+1000', '+2000', '+5000'],
                          onSelected: (index, int i, isSelected) async {
                            _addValues(result, index);
                            setState(() {
                              amountcontroller.text = result;
                            });
                            print(i);
                          },
                          options: GroupButtonOptions(
                              groupRunAlignment: GroupRunAlignment.start,
                              unselectedTextStyle: const TextStyle(
                                  fontSize: 12, color: Colors.black),
                              textPadding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              textAlign: TextAlign.center,
                              buttonHeight: 35,
                              runSpacing: 25,
                              selectedTextStyle:
                                  const TextStyle(color: Color(0xFFBF5F0B)),
                              selectedColor: Colors.transparent,
                              unselectedColor: Colors.transparent,
                              alignment: Alignment.center,
                              unselectedBorderColor: Colors.black,
                              selectedBorderColor: const Color(0xFFBF5F0B),
                              borderRadius: BorderRadius.circular(5),
                              mainGroupAlignment: MainGroupAlignment.start),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: CommonButton(
                                width: 130,
                                text: 'ADD MONEY',
                                onselect: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => AddMoneyScreen(
                                  //             getAmount: result)));

                                  walletprovider
                                      .addWalletMoney(
                                          context: context,
                                          setState: setState,
                                          amount: result)
                                      .then((value) {
                                    if (value?.status?.httpCode == '200') {
                                      openCheckout(
                                          value?.data?.body?.razorpayId ?? '',
                                          value?.data?.body?.amount ?? 0);
                                    }
                                  });
                                })),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RechargeHistoryScreen()));
                    },
                    child: cardItem(
                        const Icon(
                          Icons.wallet_rounded,
                          color: Color(0xFFBF5F0B),
                        ),
                        'RECHARGE HISTORY'),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BillingHistoryScreen()));
                    },
                    child: cardItem(
                        const Icon(
                          Icons.receipt_outlined,
                          color: Color(0xFFBF5F0B),
                        ),
                        'BILLING HISTORY'),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: cardItem(
                          Image.asset(
                            'assets/images/clock.png',
                            width: 22,
                            height: 22,
                            color: Color(0xFFBF5F0B),
                          ),
                          'VIEW AUTO RECHARGE'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  cardItem(Widget icon, String text) {
    return Container(
      width: 110,
      height: 110,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(252, 242, 199, 161),
            child: icon,
            // child: Icon(
            //   icon,
            //   color: Color(0xFFBF5F0B),
            // ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  void openCheckout(String orderId, double amount) {
    var options = {
      'key': 'rzp_test_6RDAELPDeFpXXx',
      'amount': amount *
          100, // amount in the smallest currency unit (e.g., 50000 paise for INR 500)
      'name': 'Go build',
      'description': 'payment for purchage',
      'image': 'assets/images/logo.png',
      'order_id': orderId, // Generate order_id using your server
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'notes': {'address': 'Razorpay Corporate Office'},
      // 'theme': {'color': '#F37254'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    Fluttertoast.showToast(msg: "Payment ID: ${response.message}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    String? razorOrderId = response.orderId;
    String? razorPaymentId = response.paymentId;
    String? razorSignature = response.signature;
    print({'order id': razorOrderId});
    print({'payment id ': razorPaymentId});
    print({'signature': razorSignature});

    walletprovider
        .verifyWalletMoney(
            context: context,
            setState: setState,
            razorpayId: razorOrderId,
            paymentId: razorPaymentId,
            razorpaySignature: razorSignature)
        .then((value) {
      if (value?.data?.statusCodeValue == 200) {
        Fluttertoast.showToast(
            msg: "Payment Transaction ${value?.data?.body?.status}",
            backgroundColor: Colors.green);
        walletprovider.getWallet(context: context, setState: setState);
      } else {
        Fluttertoast.showToast(
            msg: "${value?.data?.body?.status}", backgroundColor: Colors.green);
      }
    });
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "Payment ID: ${response.walletName}");
  }
}
