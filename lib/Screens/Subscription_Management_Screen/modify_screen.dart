import 'package:e_basket/Providers/SubscriptionProvider.dart';
import 'package:e_basket/Screens/Subscription_Management_Screen/MySubscription_screen.dart';
import 'package:e_basket/common_file/BuyAndScubscribe_container.dart';
import 'package:e_basket/common_file/custom_showdailog.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModifyScreen extends StatefulWidget {
  final String titleName;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final int quentity;
  final int subscriptionId;
  final bool temporary;
  const ModifyScreen(
      {super.key,
      required this.titleName,
      required this.imageUrl,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.quentity,
      required this.subscriptionId,
      required this.temporary});

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  Subscriptionprovider subscriptionprovider = Subscriptionprovider();
  int quentity = 1;
  int subscriptionId = 0;
  bool visible = false;
  String? startdate;
  String? enddate;
  String? startDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1)));
  String? endDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1)));
  String defaultdate =
      DateFormat.yMMMEd().format(DateTime.now().add(Duration(days: 1)));
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
        leading: IconButton(
            onPressed: () {
              if (quentity == widget.quentity) {
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomShowdailog(
                        title: 'Save Changes?',
                        subtitle:
                            'Your Subscription has been modified. Do you want to save the changes?',
                        buttons: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (widget.temporary == true) {
                                    print('update temporary');
                                    subscriptionprovider
                                        .updateSubscriptionTemorary(
                                            context: context,
                                            setState: setState,
                                            subscriptionId: subscriptionId,
                                            startDate: startDate,
                                            pauseDate: endDate,
                                            quentity: quentity)
                                        .then((value) {
                                      if (value?.status?.httpCode == '200') {
                                        print(
                                            'object.......,.,. ${value?.data?.productName}');
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CustomShowdailog(
                                                  title: 'Update Successful',
                                                  subtitle:
                                                      'Your Subscription has been modified as requested',
                                                  buttons: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
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
                                                                      .circular(
                                                                          20)),
                                                          child: Center(
                                                            child: Text(
                                                              'OK',
                                                              style:
                                                                  TextConstant()
                                                                      .buttonText,
                                                            ),
                                                          ))));
                                            });
                                      }
                                    });
                                  } else {
                                    print('update permanently');
                                    subscriptionprovider
                                        .updateSubscription(
                                            context: context,
                                            setState: setState,
                                            subscriptionId: subscriptionId,
                                            quentity: quentity)
                                        .then((value) {
                                      if (value?.status?.httpCode == '200') {
                                        print(
                                            'object ${value?.data?.productName}');
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CustomShowdailog(
                                                  title: 'Update Successful',
                                                  subtitle:
                                                      'Your Subscription has been modified as requested',
                                                  buttons: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
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
                                                                      .circular(
                                                                          20)),
                                                          child: Center(
                                                            child: Text(
                                                              'OK',
                                                              style:
                                                                  TextConstant()
                                                                      .buttonText,
                                                            ),
                                                          ))));
                                            });
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      gradient: ColorConstant().bottonColor,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                    child: Text(
                                      'YES',
                                      style: TextConstant().flotingSubtitle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorConstant().textColor),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                    child: Text(
                                      'NO',
                                      style: TextConstant().icontext,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ));
                  },
                );
              }
            },
            icon: Icon(Icons.arrow_back)),
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
          ),
          Visibility(
            visible: widget.temporary,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Dates',
                    style: TextConstant().lableText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            pickdate(context);
                          },
                          child: datecontainer(
                              'From Date', startdate ?? defaultdate),
                        ),
                        Divider(
                          height: 0,
                        ),
                        GestureDetector(
                          onTap: () {
                            pickdate1(context);
                          },
                          child:
                              datecontainer('To Date', enddate ?? defaultdate),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: quentity == widget.quentity || visible == false
          ? Container()
          : GestureDetector(
              onTap: () {
                if (widget.temporary == true) {
                  print('update temporary');
                  subscriptionprovider
                      .updateSubscriptionTemorary(
                          context: context,
                          setState: setState,
                          subscriptionId: subscriptionId,
                          startDate: startDate,
                          pauseDate: endDate,
                          quentity: quentity)
                      .then((value) {
                    if (value?.status?.httpCode == '200') {
                      print('object.......,.,. ${value?.data?.productName}');
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomShowdailog(
                                title: 'Update Successful',
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
                                                ColorConstant().bottonColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                            'OK',
                                            style: TextConstant().buttonText,
                                          ),
                                        ))));
                          });
                    }
                  });
                } else {
                  print('update permanently');
                  subscriptionprovider
                      .updateSubscription(
                          context: context,
                          setState: setState,
                          subscriptionId: subscriptionId,
                          quentity: quentity)
                      .then((value) {
                    if (value?.status?.httpCode == '200') {
                      print('object ${value?.data?.productName}');
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomShowdailog(
                                title: 'Update Successful',
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
                                                ColorConstant().bottonColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                            'OK',
                                            style: TextConstant().buttonText,
                                          ),
                                        ))));
                          });
                    }
                  });
                }
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

  Future pickdate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        // currentDate: DateTime.now().add(Duration(days: 1)),
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime
            .now(), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().add(Duration(days: 60)));

    if (pickedDate != null) {
      startDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          'startdate$startDate'); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat.yMMMEd().format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        startdate = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future pickdate1(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        // currentDate: DateTime.now().add(Duration(days: 1)),
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime
            .now(), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().add(Duration(days: 60)));

    if (pickedDate != null) {
      endDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          'startdate$startDate'); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat.yMMMEd().format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        enddate = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  datecontainer(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: TextConstant().subtitleText,
      ),
      subtitle: Text(
        subtitle,
        style: TextConstant().lableText,
      ),
      trailing: Icon(
        Icons.calendar_today_outlined,
        size: 18,
      ),
    );
  }
}
