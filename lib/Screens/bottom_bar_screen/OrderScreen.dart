import 'package:e_basket/Providers/CartManagementProvider.dart';
import 'package:e_basket/Screens/Subscription_Management_Screen/MySubscription_screen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Orderscreen extends StatefulWidget {
  final bool? backPage;
  const Orderscreen({super.key, this.backPage});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  Cartmanagementprovider cartmanagementprovider = Cartmanagementprovider();
  DateTime selectedDate = DateTime.now();
  ScrollController _scrollController = ScrollController();
  double itemWidth = 58.0; // Width of each item in the ListView
  late PageController _pageController;
  double viewportFraction = 1 / 7;
  @override
  void initState() {
    super.initState();
    final initialPage =
        getSurroundingDays(DateTime.now()).indexOf(selectedDate);
    _pageController = PageController(
      initialPage: initialPage,
      viewportFraction: viewportFraction,
    );
    cartmanagementprovider.getMyoredrList(
        context: context, setState: setState, selectedDate: selectedDate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate(selectedDate);
    });
    _pageController.addListener(() {
      int index = _pageController.page!.round();
      List<DateTime> surroundingDays = getSurroundingDays(DateTime.now());
      if (index >= 0 && index < surroundingDays.length) {
        setState(() {
          selectedDate = surroundingDays[index];
        });
      }
    });
    // // Add scroll listener
    // _scrollController.addListener(() {
    //   int index = (_scrollController.offset / itemWidth).floor();
    //   print('fgfgfgfgf$index');
    //   List<DateTime> surroundingDays = getSurroundingDays(DateTime.now());
    //   if (index >= 0 && index < surroundingDays.length) {
    //     setState(() {
    //       selectedDate = surroundingDays[index];
    //     });
    //   }
    // });
  }

  List items = ['ghgh', 'hghjhj', 'hjhjhj'];
  List<DateTime> getSurroundingDays(DateTime currentDate) {
    List<DateTime> days = [];
    for (int i = -45; i <= 45; i++) {
      days.add(currentDate.add(Duration(days: i)));
    }
    return days;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 45)),
      lastDate: DateTime.now().add(Duration(days: 45)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _scrollToSelectedDate(picked);
        // _scrollToSelectedDate1(picked);
      });
      cartmanagementprovider.getMyoredrList(
          context: context, setState: setState, selectedDate: selectedDate);
    }
  }

  // void _scrollToSelectedDate(DateTime date) {
  //   final List<DateTime> surroundingDays = getSurroundingDays(DateTime.now());
  //   final int index = surroundingDays.indexWhere((day) =>
  //       day.day == date.day &&
  //       day.month == date.month &&
  //       day.year == date.year);
  //   if (index != -1) {
  //     double screenWidth = MediaQuery.of(context).size.width;
  //     double itemWidth = 58.0; // Adjust based on actual item width
  //     // double offset = (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

  //     double centerOffset = screenWidth / 2 - itemWidth / 2;
  //     double scrollOffset = index * itemWidth - centerOffset;
  //     // Ensure scrollOffset does not exceed the bounds of the list

  //     double maxScrollExtent = _scrollController.position.maxScrollExtent;
  //     double newOffset = scrollOffset.clamp(0.0, maxScrollExtent);
  //     _scrollController.animateTo(
  //       newOffset,
  //       // offset,

  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  void _scrollToSelectedDate(DateTime date) {
    final List<DateTime> surroundingDays = getSurroundingDays(DateTime.now());
    final int index = surroundingDays.indexWhere((day) =>
        day.day == date.day &&
        day.month == date.month &&
        day.year == date.year);
    if (index != -1) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> surroundingDays = getSurroundingDays(DateTime.now());
    // print('selec......$getdata');
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              if (widget.backPage == true) {
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
        centerTitle: true,
        elevation: 10,
        titleSpacing: 20,
        title: GestureDetector(
          onTap: () => _selectDate(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('MMM d').format(selectedDate)),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
        actions: [
          selectedDate.day == DateTime.now().day &&
                  selectedDate.month == DateTime.now().month &&
                  selectedDate.year == DateTime.now().year
              ? Container()
              : IconButton(
                  padding: EdgeInsets.only(left: 20),
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () {
                    setState(() {
                      selectedDate = DateTime.now();
                      _scrollToSelectedDate(DateTime.now());
                    });
                    cartmanagementprovider.getMyoredrList(
                        context: context,
                        setState: setState,
                        selectedDate: selectedDate);
                  }),
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    side: BorderSide(), borderRadius: BorderRadius.zero),
                insetPadding: EdgeInsets.only(
                  left: 60,
                ),
                // actionsAlignment: MainAxisAlignment.end,
                alignment: Alignment.topRight,
                content: Container(
                  width: 80,
                  height: 20,
                  child: Center(child: Text('Generate Invoice')),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
                // color: Colors.white,
                border: Border(top: BorderSide(width: 0.3))),

            child: PageView.builder(
                controller: _pageController,
                itemCount: surroundingDays.length,
                onPageChanged: (value) {
                  DateTime day = surroundingDays[value];
                  print('scroll page:-$day');
                  cartmanagementprovider.getMyoredrList(
                      context: context,
                      setState: setState,
                      selectedDate: selectedDate);
                },
                itemBuilder: (context, index) {
                  DateTime day = surroundingDays[index];

                  bool isSelected = day.day == selectedDate.day &&
                      day.month == selectedDate.month &&
                      day.year == selectedDate.year;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = day;
                        _scrollToSelectedDate(day);
                      });
                      cartmanagementprovider.getMyoredrList(
                          context: context,
                          setState: setState,
                          selectedDate: selectedDate);
                    },
                    child: Container(
                      width: itemWidth,
                      // margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE').format(day),
                            style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black),
                          ),
                          Text(
                            DateFormat('dd').format(day),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            // child: ListView.builder(
            //   physics: ScrollPhysics(),
            //   shrinkWrap: true,
            //   controller: _scrollController,
            //   scrollDirection: Axis.horizontal,
            //   itemCount: surroundingDays.length,
            //   itemBuilder: (context, index) {
            //     DateTime day = surroundingDays[index];

            //     bool isSelected = day.day == selectedDate.day &&
            //         day.month == selectedDate.month &&
            //         day.year == selectedDate.year;

            //     return GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           selectedDate = day;
            //           _scrollToSelectedDate(day);
            //         });
            //         cartmanagementprovider.getMyoredrList(
            //             context: context,
            //             setState: setState,
            //             selectedDate: selectedDate);
            //       },
            //       child: Container(
            //         width: itemWidth,
            //         // margin: const EdgeInsets.symmetric(horizontal: 5),
            //         decoration: BoxDecoration(
            //           color: isSelected ? Colors.red : Colors.transparent,
            //         ),
            //         alignment: Alignment.center,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               DateFormat('EEE').format(day),
            //               style: TextStyle(
            //                   color: isSelected ? Colors.white : Colors.black),
            //             ),
            //             Text(
            //               DateFormat('dd').format(day),
            //               style: TextStyle(
            //                 color: isSelected ? Colors.white : Colors.black,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ),
        ),
      ),
      body: (cartmanagementprovider
                      .myOrderListModel?.data?.productDeliveryInfoList ??
                  [])
              .isEmpty
          ? Center(
              child: Text('No Data Found'),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      // borderRadius: BorderRadius.circular(5)
                    ),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: []..addAll([
                          ...?cartmanagementprovider
                              .myOrderListModel?.data!.productDeliveryInfoList!
                              .map((data) {
                            return Column(
                              children: [
                                data.deliveryStatus == 'DELIVERED'
                                    ? deliveredItem()
                                    : data.deliveryStatus == 'PENDING'
                                        ? pendingItem()
                                        : pauseItem(),
                                // Divider(
                                //   height: 0.5,
                                //   color: Colors.black26,
                                // ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                data.productImageUrl ??
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: data.orderType ==
                                                            'buyOnce'
                                                        ? Colors.blue[100]
                                                        : Colors.green[200]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Text(
                                                    data.orderType == 'buyOnce'
                                                        ? 'BUY ONCE'
                                                        : 'SUBSCRIPTION',
                                                    style: TextStyle(
                                                        color: data.orderType ==
                                                                'buyOnce'
                                                            ? Colors.blueAccent
                                                            : Colors.green[700],
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                data.productName ?? '',
                                                style: TextConstant()
                                                    .cardtitleText,
                                              ),
                                              Text(
                                                'Qty: ${data.quantity}',
                                                style:
                                                    TextConstant().subtitleText,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                '\u20B9 ${data.offerPrice}',
                                                style: TextConstant()
                                                    .cardtitleText,
                                              )
                                            ],
                                          ),
                                        ),
                                        data.deliveryStatus == 'Delivered'
                                            ? Container()
                                            : data.orderType == 'buyOnce'
                                                ? IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons
                                                          .delete_outline_outlined,
                                                      size: 24,
                                                    ))
                                                : IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MysubscriptionScreen()));
                                                    },
                                                    icon: Icon(
                                                      Icons.calendar_month,
                                                      size: 24,
                                                    ))
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                  color: Colors.blueGrey[50],
                                  thickness: 15,
                                ),
                                cartmanagementprovider
                                            .myOrderListModel
                                            ?.data
                                            ?.orderDeliverySummary
                                            ?.deliveryStatus ==
                                        null
                                    ? Container()
                                    : Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              top: 10,
                                              bottom: 10,
                                              right: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Order Summary',
                                                style: TextConstant().titleText,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Sub Total :',
                                                  ),
                                                  Text('\u20B9',
                                                      style: TextConstant()
                                                          .lableText)
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Text(
                                                          'Delivery Charge : '),
                                                      Icon(
                                                        Icons.info_outline,
                                                        size: 16,
                                                      ),
                                                    ],
                                                  ),
                                                  Text('\u20B9',
                                                      style: TextConstant()
                                                          .lableText)
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Total:',
                                                    style: TextConstant()
                                                        .titleText,
                                                  ),
                                                  Text(
                                                    '\u20B9',
                                                    style: TextConstant()
                                                        .cardtitleText,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    top: 5,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'SAVINGS',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      '\u20B910.0',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                              ],
                            );
                          })
                        ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 30),
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
                ],
              ),
            ),
    );
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

  void onChanged(surroundingDay) {
    _scrollToSelectedDate(surroundingDay);

    setState(() {
      print('object$surroundingDay');
    });
  }

  deliveredItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Delivered',
            style: TextConstant().subtitleText,
          )
        ],
      ),
    );
  }

  pauseItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Row(
        children: [
          Icon(
            Icons.pause_circle_outline_outlined,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Pause',
            style: TextConstant().subtitleText,
          )
        ],
      ),
    );
  }

  pendingItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Row(
        children: [
          Icon(
            Icons.access_time_filled_outlined,
            color: Colors.yellow,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'To be Delivered',
            style: TextConstant().subtitleText,
          )
        ],
      ),
    );
  }
}
