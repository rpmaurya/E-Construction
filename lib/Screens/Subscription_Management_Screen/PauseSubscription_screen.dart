import 'package:e_basket/Providers/SubscriptionProvider.dart';
import 'package:e_basket/common_file/custom_showdailog.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PausesubscriptionScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final int quentity;
  final int subscriptionId;
  final bool visible;
  const PausesubscriptionScreen(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subtitle,
      required this.quentity,
      required this.price,
      required this.subscriptionId,
      required this.visible});

  @override
  State<PausesubscriptionScreen> createState() =>
      _PausesubscriptionScreenState();
}

class _PausesubscriptionScreenState extends State<PausesubscriptionScreen> {
  Subscriptionprovider subscriptionprovider = Subscriptionprovider();
  int quentity = 1;
  int subscriptionId = 0;
  // bool visible = false;
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
        title: Text('Pause Subscription'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
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
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          Text('Qty: ${widget.quentity}'),
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
          ),
          Container(
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
                        child: datecontainer('To Date', enddate ?? defaultdate),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        color: Colors.white,
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Subscription Resume on',
                    style: TextConstant().subtitleText,
                  ),
                  Text(
                    defaultdate,
                    style: TextConstant().cardtitleText,
                  )
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  subscriptionprovider
                      .pauseSubscription(
                          context: context,
                          setState: setState,
                          subscriptionId: subscriptionId,
                          startDate: startDate,
                          pauseDate: endDate)
                      .then((value) {
                    if (value?.status?.httpCode == '200') {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomShowdailog(
                                title: 'Subscription Pause',
                                subtitle:
                                    'Your Subscription has been pause as requested,you can tap on resume to continue the services',
                                buttons: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      widget.visible == true
                                          ? Navigator.pop(context)
                                          : null;
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
                },
                child: Container(
                    color: Colors.pink,
                    child: const Center(
                        child: Text(
                      'Pause Subscription',
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
