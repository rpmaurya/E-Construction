import 'package:e_basket/Providers/SubscriptionProvider.dart';
import 'package:e_basket/common_file/BuyAndScubscribe_container.dart';
import 'package:e_basket/common_file/custom_showdailog.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';

class ModifyScreen extends StatefulWidget {
  final String titleName;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final int quentity;
  final int subscriptionId;
  const ModifyScreen(
      {super.key,
      required this.titleName,
      required this.imageUrl,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.quentity,
      required this.subscriptionId});

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  Subscriptionprovider subscriptionprovider = Subscriptionprovider();
  int quentity = 1;
  int subscriptionId = 0;
  bool visible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quentity = widget.quentity;
    subscriptionId = widget.subscriptionId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(widget.titleName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BuyandscubscribeContainer(
                imageurl: widget.imageUrl,
                titletext: widget.title,
                subtitletext: 'Qty: ${widget.subtitle}',
                pricetext: widget.price,
                removeQuentity: quentity <= 1
                    ? null
                    : () {
                        visible = true;
                        setState(() {
                          --quentity;
                        });
                        print('updated subscription$quentity');
                        print('updated subscription$visible');
                      },
                quentity: '$quentity',
                addQuentity: () {
                  visible = true;
                  setState(() {
                    ++quentity;
                  });
                  print('updated subscription$quentity');
                }),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: quentity == widget.quentity || visible == false
          ? Container()
          : GestureDetector(
              onTap: () {
                subscriptionprovider
                    .updateSubscription(
                        context: context,
                        setState: setState,
                        subscriptionId: subscriptionId,
                        quentity: quentity)
                    .then((value) {
                  if (value?.status?.httpCode == '200') {
                    print('object ${value?.data?.productName}');
                    CustomShowdailog(
                        title: 'success',
                        subtitle: 'cccsacsacc',
                        buttons: Container(
                          child: Text('ok'),
                        ));
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 40,
                decoration: BoxDecoration(
                    gradient: ColorConstant().bottonColor,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text(
                  'Update subscription',
                  style: TextConstant().buttonText,
                )),
              ),
            ),
    );
  }
}
