import 'package:e_basket/Providers/SubscriptionProvider.dart';
import 'package:e_basket/common_file/custom_showdailog.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeletesubscriptionScreen extends StatefulWidget {
  final String? imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final int subscriptionId;
  const DeletesubscriptionScreen(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.subscriptionId});

  @override
  State<DeletesubscriptionScreen> createState() =>
      _DeletesubscriptionScreenState();
}

class _DeletesubscriptionScreenState extends State<DeletesubscriptionScreen> {
  Subscriptionprovider subscriptionprovider = Subscriptionprovider();

  List<String> items = [
    'Changing the product or subscription frequency',
    'Placing orders from a diffirent account',
    'Delivery charges are high',
    'Coupon validity is oveer',
    'Quelity is not good',
    'Pieces are high'
  ];
  String selectedValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('Delete Subscription'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.imageUrl ??
                                'https://tse4.mm.bing.net/th?id=OIP.8vtlhiG0ozEzXbDlax-91gAAAA&pid=Api&P=0&h=220',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextConstant().cardtitleText,
                          ),
                          Text(
                            widget.subtitle,
                            style: TextConstant().subtitleText,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '\u20B9 ${widget.price}',
                            style: TextConstant().cardtitleText,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Cancellation Reason',
              style: TextConstant().cardtitleText,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Column(
                  children: [
                    Column(
                      children: items.map((item) {
                        return RadioListTile(
                          dense: true,
                          value: item,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                              print('selected value $selectedValue');
                            });
                          },
                          title: Text(
                            item,
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            'Note:-',
                            style: TextConstant().lableText,
                          ),
                          const Expanded(
                            child: Text(
                              'Please select accurate reason for quicker refund process',
                              style: TextStyle(fontSize: 11),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: selectedValue.isEmpty
                          ? null
                          : () {
                              subscriptionprovider
                                  .deleteSubscription(
                                      context: context,
                                      setState: setState,
                                      subscriptionId: widget.subscriptionId,
                                      reason: selectedValue)
                                  .then((value) {
                                if (value?.status?.httpCode == '200') {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomShowdailog(
                                            title: 'Delete Successful',
                                            subtitle:
                                                'Your Subscription has been modified as requested',
                                            buttons: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                    height: 40,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            ColorConstant()
                                                                .bottonColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Center(
                                                      child: Text(
                                                        'OK',
                                                        style: TextConstant()
                                                            .buttonText,
                                                      ),
                                                    ))));
                                      });
                                }
                              });
                            },
                      child: Container(
                        height: 40,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: selectedValue.isEmpty
                                ? ColorConstant().bottonBlurColor
                                : ColorConstant().bottonColor),
                        child: Center(
                          child: Text(
                            'DELETE SUBSCRIPTION',
                            style: TextConstant().buttonText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
