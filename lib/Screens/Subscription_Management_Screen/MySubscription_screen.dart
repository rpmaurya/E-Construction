import 'package:e_basket/Providers/SubscriptionProvider.dart';
import 'package:e_basket/Screens/Subscription_Management_Screen/DeleteSubscription_Screen.dart';
import 'package:e_basket/Screens/Subscription_Management_Screen/PauseSubscription_screen.dart';
import 'package:e_basket/Screens/Subscription_Management_Screen/modify_screen.dart';

import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:e_basket/models/GetSubscriptionModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class MysubscriptionScreen extends StatefulWidget {
  const MysubscriptionScreen({super.key});

  @override
  State<MysubscriptionScreen> createState() => _MysubscriptionScreenState();
}

class _MysubscriptionScreenState extends State<MysubscriptionScreen> {
  Subscriptionprovider subscriptionprovider = Subscriptionprovider();
  bool visible = false;
  List<Content> dataList = [];

  int currentPage = 0;
  bool lastPage = false;
  bool isLoading = false;
  int itemsPerPage = 10;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItems();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('object......./////');
        if (!isLoading && !lastPage) {
          fetchItems();
        }
      }
    });
  }

  Future<void> fetchItems() async {
    if (isLoading || lastPage) return;
    setState(() {
      isLoading = true;
    });
    await subscriptionprovider.getSubscription(
        context: context,
        setState: setState,
        currentPage: currentPage,
        pagesize: itemsPerPage);
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    // List<int> newItems = List.generate(
    //     itemsPerPage, (index) => (currentPage) * itemsPerPage + index + 1);
    // print('newvalue$newItems');

    var newData = subscriptionprovider.getSubscriptionModel?.data?.content;

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

  Future<void> updatedData() async {
    setState(() {
      currentPage = 0;
      lastPage = false;
      dataList.clear();
    });
    await fetchItems();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('My Subscription'),
          centerTitle: true,
        ),
        body: dataList.isEmpty
            ? Center(
                child: Text('No Data Found'),
              )
            : ListView.builder(
                controller: _scrollController,
                itemCount: dataList.length + (isLoading || lastPage ? 1 : 0),
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
                  var getdata = dataList;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: getdata[index].temporaryQuantity == 0
                              ? Colors.white.withOpacity(0.6)
                              : Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset.infinite,
                              blurStyle: BlurStyle.solid,
                            )
                          ],
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text('Subscription:'),
                                Text(
                                  ' ${getdata[index].subscriptionType}',
                                  style: TextConstant().subtitleText,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    getdata[index].imageUrl ??
                                        'https://tse4.mm.bing.net/th?id=OIP.8vtlhiG0ozEzXbDlax-91gAAAA&pid=Api&P=0&h=220',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getdata[index].productName.toString(),
                                        style: TextConstant().lableText,
                                      ),
                                      Text(getdata[index]
                                                  .subscriptionChangeStatus ==
                                              'Temporary'
                                          ? 'Qty : ${getdata[index].temporaryQuantity}'
                                          : 'Qty : ${getdata[index].quantity}'),
                                      Text(
                                        '\u20B9${getdata[index].price}',
                                        style: TextConstant().lableText,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          getdata[index].subscriptionChangeStatus != 'Temporary'
                              ? Container()
                              : getdata[index].temporaryQuantity == 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(
                                          'Your Subscription has been pause from  ${DateFormat('dd-MM-yyyy').format(getdata[index].startDate ?? DateTime.now())} to ${DateFormat('dd-MM-yyyy').format(getdata[index].pauseDate ?? DateTime.now())}. to continue services tap on resume',
                                          style: const TextStyle(
                                              color: Colors.red, fontSize: 10)),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(
                                          'Your Subscription has been modified from  ${DateFormat('dd-MM-yyyy').format(getdata[index].startDate ?? DateTime.now())} to ${DateFormat('dd-MM-yyyy').format(getdata[index].pauseDate ?? DateTime.now())}',
                                          style: const TextStyle(
                                              color: Colors.red, fontSize: 10)),
                                    ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 0,
                          ),
                          getdata[index].subscriptionChangeStatus == 'Temporary'
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showdailog(
                                            context,
                                            'Holiday Mode',
                                            'Your can pause your subscription for a duration and it will resume once you are back automatically.',
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DeletesubscriptionScreen(
                                                                    imageUrl: getdata[
                                                                            index]
                                                                        .imageUrl,
                                                                    title: getdata[index]
                                                                            .productName ??
                                                                        '',
                                                                    subtitle:
                                                                        getdata[index].productName ??
                                                                            '',
                                                                    price:
                                                                        '${getdata[index].price}',
                                                                    subscriptionId:
                                                                        getdata[index].subscriptionId ??
                                                                            0,
                                                                  ))).then(
                                                          (value) {
                                                        updatedData();
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  ColorConstant()
                                                                      .textColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: Center(
                                                        child: Text(
                                                          'DELETE',
                                                          style: TextConstant()
                                                              .icontext,
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
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PausesubscriptionScreen(
                                                                    imageUrl:
                                                                        getdata[index].imageUrl ??
                                                                            '',
                                                                    title: getdata[index]
                                                                            .productName ??
                                                                        '',
                                                                    subtitle:
                                                                        getdata[index].productName ??
                                                                            '',
                                                                    quentity:
                                                                        getdata[index].quantity ??
                                                                            0,
                                                                    price:
                                                                        '${getdata[index].price}',
                                                                    subscriptionId:
                                                                        getdata[index].subscriptionId ??
                                                                            0,
                                                                    visible:
                                                                        true,
                                                                    startDateTime:
                                                                        getdata[index]
                                                                            .startDate,
                                                                  ))).then(
                                                          (value) {
                                                        updatedData();
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              ColorConstant()
                                                                  .bottonColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: Center(
                                                        child: Text(
                                                          'PAUSE',
                                                          style: TextConstant()
                                                              .flotingSubtitle,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ));
                                      },
                                      child: iconbutton(
                                          Icons.delete_outlined, 'DELETE'),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        subscriptionprovider
                                            .resumeSubscription(
                                                context: context,
                                                setState: setState,
                                                subscriptionId: getdata[index]
                                                    .subscriptionId)
                                            .then((value) {
                                          if (value?.status?.httpCode ==
                                              '200') {
                                            updatedData();
                                            Fluttertoast.showToast(
                                                msg: value?.data?.body ?? '');
                                          }
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient:
                                                ColorConstant().bottonColor),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.play_circle_outline,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'RESUME',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showdailog(
                                              context,
                                              'Modify Subscription',
                                              'Your can modify your subscription for a time being or permanently',
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return ModifyScreen(
                                                          titleName:
                                                              'Update Temporarily',
                                                          imageUrl: getdata[
                                                                      index]
                                                                  .imageUrl ??
                                                              '',
                                                          title: getdata[index]
                                                                  .productName ??
                                                              '',
                                                          subtitle:
                                                              '${getdata[index].quantity}',
                                                          price:
                                                              '${getdata[index].price}',
                                                          quentity: getdata[
                                                                      index]
                                                                  .quantity ??
                                                              0,
                                                          subscriptionId: getdata[
                                                                      index]
                                                                  .subscriptionId ??
                                                              0,
                                                          temporary: true,
                                                          startDate:
                                                              getdata[index]
                                                                  .startDate,
                                                        );
                                                      })).then((value) {
                                                        updatedData();
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              ColorConstant()
                                                                  .bottonColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: Center(
                                                        child: Text(
                                                          'MODIFY TEMPORARLY',
                                                          style: TextConstant()
                                                              .flotingSubtitle,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return ModifyScreen(
                                                          titleName:
                                                              'Update Permanently',
                                                          imageUrl: getdata[
                                                                      index]
                                                                  .imageUrl ??
                                                              '',
                                                          title: getdata[index]
                                                                  .productName ??
                                                              '',
                                                          subtitle:
                                                              '${getdata[index].quantity}',
                                                          price:
                                                              '${getdata[index].price}',
                                                          quentity: getdata[
                                                                      index]
                                                                  .quantity ??
                                                              0,
                                                          subscriptionId: getdata[
                                                                      index]
                                                                  .subscriptionId ??
                                                              0,
                                                          temporary: false,
                                                        );
                                                      })).then((onValue) {
                                                        print(
                                                            'updated data......');
                                                        // fetchItems();
                                                        updatedData();
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  ColorConstant()
                                                                      .textColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: Center(
                                                        child: Text(
                                                          'UPDATE PERMANENTLY',
                                                          style: TextConstant()
                                                              .icontext,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        },
                                        child: iconbutton(
                                            Icons.calendar_month, 'MODIFY'),
                                      ),
                                      SizedBox(
                                          height: 18,
                                          child: VerticalDivider(
                                            color: ColorConstant().textColor,
                                          )),
                                      GestureDetector(
                                        onTap: () {
                                          showdailog(
                                              context,
                                              'Holiday Mode',
                                              'Your can pause your subscription for a duration and it will resume once you are back automatically.',
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DeletesubscriptionScreen(
                                                                    imageUrl:
                                                                        getdata[index].imageUrl ??
                                                                            '',
                                                                    title: getdata[index]
                                                                            .productName ??
                                                                        '',
                                                                    subtitle:
                                                                        getdata[index].productName ??
                                                                            '',
                                                                    price:
                                                                        '${getdata[index].price}',
                                                                    subscriptionId:
                                                                        getdata[index].subscriptionId ??
                                                                            0,
                                                                  )),
                                                        ).then((value) {
                                                          updatedData();
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 35,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: ColorConstant()
                                                                    .textColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        child: Center(
                                                          child: Text(
                                                            'DELETE',
                                                            style:
                                                                TextConstant()
                                                                    .icontext,
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
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PausesubscriptionScreen(
                                                                          imageUrl:
                                                                              getdata[index].imageUrl ?? '',
                                                                          title:
                                                                              getdata[index].productName ?? '',
                                                                          subtitle:
                                                                              getdata[index].productName ?? '',
                                                                          quentity:
                                                                              getdata[index].quantity ?? 0,
                                                                          price:
                                                                              '${getdata[index].price}',
                                                                          subscriptionId:
                                                                              getdata[index].subscriptionId ?? 0,
                                                                          visible:
                                                                              true,
                                                                          startDateTime:
                                                                              getdata[index].startDate,
                                                                        ))).then(
                                                            (value) {
                                                          updatedData();
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 35,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            gradient:
                                                                ColorConstant()
                                                                    .bottonColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        child: Center(
                                                          child: Text(
                                                            'PAUSE',
                                                            style: TextConstant()
                                                                .flotingSubtitle,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        },
                                        child:
                                            iconbutton(Icons.delete, 'DELETE'),
                                      ),
                                      SizedBox(
                                          height: 18,
                                          child: VerticalDivider(
                                              color:
                                                  ColorConstant().textColor)),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PausesubscriptionScreen(
                                                        imageUrl: getdata[index]
                                                                .imageUrl ??
                                                            '',
                                                        title: getdata[index]
                                                                .productName ??
                                                            '',
                                                        subtitle: getdata[index]
                                                                .productName ??
                                                            '',
                                                        quentity: getdata[index]
                                                                .quantity ??
                                                            0,
                                                        price:
                                                            '${getdata[index].price}',
                                                        subscriptionId: getdata[
                                                                    index]
                                                                .subscriptionId ??
                                                            0,
                                                        visible: false,
                                                        startDateTime:
                                                            getdata[index]
                                                                .startDate,
                                                      ))).then((value) {
                                            updatedData();
                                          });
                                        },
                                        child: iconbutton(
                                            Icons.pause_circle_outline_outlined,
                                            'PAUSE'),
                                      )
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ),
                  );
                }));
  }

  iconbutton(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: ColorConstant().textColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextConstant().icontext,
        )
      ],
    );
  }

  showdailog(BuildContext context, String title, String subtitle,
      Widget buttons) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              color: Colors.white,
              constraints: BoxConstraints(maxHeight: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/e-construction.png',
                    scale: 2.5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    // 'Modify Subscription',
                    style: TextConstant().lableText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    subtitle,
                    // 'Your can modify your subscription for a time being or permanently',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buttons
                ],
              ),
            ),
          );
        });
  }
}
