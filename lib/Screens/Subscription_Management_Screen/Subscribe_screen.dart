import 'package:e_basket/Providers/SubscriptionProvider.dart';
import 'package:e_basket/Screens/Subscription_Management_Screen/Success_subscribe_screen.dart';
import 'package:e_basket/common_file/BuyAndScubscribe_container.dart';
import 'package:e_basket/common_file/custom_datePickerCard.dart';

import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:e_basket/models/ProductSubscriptionModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:provider/provider.dart';

class SubscribeScreen extends StatefulWidget {
  final ProductSubscriptionModel? getdata;
  const SubscribeScreen({super.key, required this.getdata});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  DateTime today = DateUtils.dateOnly(DateTime.now());
  int quentity = 1;
  String date = '';
  String? startDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1)));
  bool visible = false;
  bool disable = false;
  bool? selected = false;
  String defaultdate =
      DateFormat.yMMMEd().format(DateTime.now().add(Duration(days: 1)));

  String formatDate(DateTime? date) {
    if (date == null) {
      return 'Invalid date';
    }
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String subscriptionType = '';
  List<String> selectedDates = [];
  List<DateTime?> _multiDatePickerValueWithDefaultValue = [];
  List<DateTime?> _previousSelection = [];
  List<String> isSelectedDays = [];
  List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thusday',
    'Friday',
    'Saturday'
  ];
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        isSelectedDays.add(itemValue);
      } else {
        isSelectedDays.remove(itemValue);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Subscriptionprovider subscriptionprovider =
        Provider.of(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          title: Text('Subscribe'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              BuyandscubscribeContainer(
                  imageurl: widget.getdata?.data?.imageUrl ??
                      'https://5.imimg.com/data5/CT/IY/XK/GLADMIN-12/jcbe1.jpeg',
                  titletext: widget.getdata?.data?.productName ?? '',
                  subtitletext: widget.getdata?.data?.productName ?? '',
                  pricetext: '${widget.getdata?.data?.price}',
                  removeQuentity: quentity <= 1
                      ? null
                      : () {
                          setState(() {
                            --quentity;
                          });
                          print('updated subscription$quentity');
                          // subscriptionprovider.updateSubscription(
                          //     context: context,
                          //     setState: setState,
                          //     subscriptionId:
                          //         widget.getdata?.data?.subscriptionId,
                          //     quentity: --quentity);
                        },
                  quentity: '${quentity}',
                  addQuentity: () {
                    setState(() {
                      ++quentity;
                    });
                    print('updated subscription$quentity');
                    // subscriptionprovider.updateSubscription(
                    //     context: context,
                    //     setState: setState,
                    //     subscriptionId: widget.getdata?.data?.subscriptionId,
                    //     quentity: ++quentity);
                  }),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15),
                      child: Text(
                        'Pick Schedule',
                        style: TextConstant().cardtitleText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 25),
                      child: GroupButton(
                        isRadio: true,
                        onSelected: (index, int i, isSelected) async {
                          if (index == 'DAILY') {
                            pickdate(context);
                            visible = true;
                          } else if (index == 'ALTERNATE') {
                            pickdate(context);
                            visible = true;
                          } else if (index == 'EVERY_3_DAYS') {
                            pickdate(context);
                            visible = true;
                          } else if (index == 'WEEKLY') {
                            showdialog(context);
                            date = defaultdate;
                            setState(() {
                              visible = true;
                            });
                          } else if (index == 'MONTHLY') {
                            showCalender(context);
                            date = defaultdate;
                            setState(() {
                              visible = true;
                            });
                          } else {
                            return null;
                          }
                          subscriptionType = index;
                          print('$subscriptionType button is selected');
                        },
                        buttons: [
                          "DAILY",
                          "ALTERNATE",
                          "EVERY_3_DAYS",
                          "WEEKLY",
                          "MONTHLY",
                        ],
                        options: GroupButtonOptions(
                            groupRunAlignment: GroupRunAlignment.start,
                            unselectedTextStyle:
                                TextStyle(fontSize: 12, color: Colors.black),
                            textPadding: EdgeInsets.only(left: 15, right: 15),
                            textAlign: TextAlign.center,
                            buttonHeight: 30,
                            runSpacing: 25,
                            selectedColor: Colors.pink,
                            unselectedColor: Colors.transparent,
                            alignment: Alignment.center,
                            unselectedBorderColor: Colors.black,
                            selectedBorderColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                            mainGroupAlignment: MainGroupAlignment.start),
                      ),
                    ),
                    visible == true
                        ? const Divider(
                            height: 0,
                          )
                        : Container(),
                    visible == true
                        ? GestureDetector(
                            onTap: () {
                              pickdate(context);
                            },
                            // child: datepickerCard(date),
                            child: CustomDatepickercard(datetext: date),
                          )
                        : Container()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/discount_image.png',
                          width: 40,
                          height: 40,
                          color: Colors.pink,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Text(
                          'Apply coupons',
                          style: TextConstant().lableText,
                        )),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Terms and Conditions',
                          style: TextConstant().cardtitleText,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        condition(
                            Image.asset(
                              'assets/images/cart_icon.png',
                              width: 24,
                            ),
                            'Subscription charges may change per market changes.'),
                        const SizedBox(
                          height: 5,
                        ),
                        condition(
                            Container(
                                decoration: BoxDecoration(
                                    color: ColorConstant().containerColor,
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all()),
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.currency_rupee,
                                    size: 18,
                                  ),
                                )),
                            'Delivery charge will be applicable on the subscription orders. If all your items are delivered together, we only charge you once.')
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: visible == true
            ? GestureDetector(
                onTap: () {
                  subscriptionprovider
                      .addSubscription(
                          context: context,
                          setState: setState,
                          subscriptionId: widget.getdata?.data?.subscriptionId,
                          quentity: quentity,
                          subscriptionType: subscriptionType,
                          startDate: startDate,
                          selectedDaysOfWeek: isSelectedDays,
                          selectedDates: selectedDates)
                      .then((value) {
                    if (value?.status?.httpCode == '200') {
                      Fluttertoast.showToast(msg: 'Subscription Successfull');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SuccessSubscribeScreen(
                                    startedDate: value?.data?.startDate ??
                                        DateTime.now().add(Duration(days: 1)),
                                  )));
                    }
                  });
                },
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.pink,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start Subscription',
                        style: TextConstant().flotingTitle,
                      ),
                      Text(
                        'From $date',
                        style: TextConstant().flotingSubtitle,
                      )
                    ],
                  ),
                ),
              )
            : Container());
  }

  condition(Widget icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        )
      ],
    );
  }

  Future pickdate(BuildContext context1) async {
    DateTime? pickedDate = await showDatePicker(
        context: context1,
        // currentDate: DateTime.now().add(Duration(days: 1)),
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      startDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          'startdate$startDate'); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat.yMMMEd().format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        date = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  showdialog(BuildContext context) async {
    await showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Container(
              height: 540,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Select Delivery Days',
                      style: TextConstant().titleText,
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView(
                        children: days.map((day) {
                      return CheckboxListTile(
                        dense: true,
                        visualDensity: VisualDensity.comfortable,
                        value: isSelectedDays.contains(day),
                        onChanged: (value) {
                          setState(() {
                            _itemChange(day, value!);
                            print({'selected value': isSelectedDays});
                          });
                        },
                        title: Text(
                          day,
                          style: TextConstant().lableText,
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList()),
                  ),
                  GestureDetector(
                    onTap: () {
                      pickdate(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 10),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black45)),
                        child: Center(
                          child: datepickerCard(date, context),
                          // child: CustomDatepickercard(datetext: date),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        gradient: isSelectedDays.isEmpty
                            ? null
                            : ColorConstant().bottonColor,
                        borderRadius: BorderRadius.circular(25)),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            visualDensity: VisualDensity.standard,
                            elevation: 0,
                            backgroundColor: Colors.transparent),
                        onPressed: isSelectedDays.isEmpty
                            ? null
                            : () {
                                setState(() {
                                  print('object');
                                  visible = true;
                                });
                                Navigator.pop(context);
                              },
                        child: Center(
                            child: Text(
                          'SUBMIT',
                          style: TextConstant().buttonText,
                        ))),
                  )
                ],
              ),
            );
          });
        });
  }

  void showCalender(BuildContext context) async {
    await showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Container(
              height: 540,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Select Delivery Dates',
                      style: TextConstant().titleText,
                    ),
                  ),
                  Expanded(
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        dayBorderRadius: BorderRadius.zero,
                        calendarType: CalendarDatePicker2Type.multi,
                        selectedDayHighlightColor:
                            disable == false ? Colors.indigo : null,
                      ),
                      value: _multiDatePickerValueWithDefaultValue,
                      onValueChanged: (dates) {
                        if (dates.length > 5) {
                          _multiDatePickerValueWithDefaultValue =
                              _previousSelection;
                          setState(() {
                            disable == true;
                          });
                          Fluttertoast.showToast(
                              msg: 'You can only select up to 5 dates');
                        } else {
                          setState(() {
                            _previousSelection = List.from(dates);
                            _multiDatePickerValueWithDefaultValue = dates;

                            List<String> formattedDates =
                                dates.map((date) => formatDate(date)).toList();

                            selectedDates = formattedDates;
                            print('Formatted Dates: $selectedDates');
                          });
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pickdate(context);
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 10),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black45)),
                        child: Center(
                          child: ListTile(
                            minTileHeight: 40,
                            // visualDensity: VisualDensity.standard,
                            leading: const Icon(
                              Icons.calendar_month,
                              size: 30,
                            ),
                            title: Text(
                              'Subscription Start Date',
                              style: TextConstant().subtitleText,
                            ),
                            subtitle: Text(
                              date,
                              style: TextConstant().lableText,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_down),
                          ),
                          // child: datepickerCard(date, context),
                          // child: CustomDatepickercard(
                          //   datetext: date,
                          // ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        gradient: _multiDatePickerValueWithDefaultValue.isEmpty
                            ? null
                            : ColorConstant().bottonColor,
                        borderRadius: BorderRadius.circular(25)),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            visualDensity: VisualDensity.standard,
                            elevation: 0,
                            backgroundColor: Colors.transparent),
                        onPressed: _multiDatePickerValueWithDefaultValue.isEmpty
                            ? null
                            : () {
                                setState(() {
                                  print('object');
                                  visible = true;
                                });
                                Navigator.pop(context);
                              },
                        child: Center(
                            child: Text(
                          'SUBMIT',
                          style: TextConstant().buttonText,
                        ))),
                  )
                ],
              ),
            );
          });
        });
  }

  datepickerCard(String text, context1) {
    return ListTile(
      minTileHeight: 40,
      // visualDensity: VisualDensity.standard,
      leading: const Icon(
        Icons.calendar_month,
        size: 30,
      ),
      title: Text(
        'Subscription Start Date',
        style: TextConstant().subtitleText,
      ),
      subtitle: Text(
        text,
        style: TextConstant().lableText,
      ),
      trailing: Icon(Icons.keyboard_arrow_down),
    );
  }

  // void showCalender() async {
  //   CalendarDatePicker2(
  //     config: config,
  //     value: _multiDatePickerValueWithDefaultValue,
  //     onValueChanged: (dates) =>
  //         setState(() => _multiDatePickerValueWithDefaultValue = dates),
  //   );
  // }
}
