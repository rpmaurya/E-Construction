import 'package:e_basket/Providers/WalletProvider.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class BillingHistoryScreen extends StatefulWidget {
  const BillingHistoryScreen({super.key});

  @override
  State<BillingHistoryScreen> createState() => _BillingHistoryScreenState();
}

class _BillingHistoryScreenState extends State<BillingHistoryScreen> {
  Walletprovider walletprovider = Walletprovider();
  TextEditingController stratDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  List items = [];
  String? startDate;

  String? endDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    stratDateController.text = DateFormat('dd MMM yyyy')
        .format(DateTime.now().subtract(Duration(days: 7)));
    endDateController.text = DateFormat('dd MMM yyyy').format(DateTime.now());
    startDate = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 7)));
    endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Billing History'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start date'),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black54))),
                    child: TextField(
                      onTap: () {
                        pickdate(context);
                      },
                      readOnly: true,
                      controller: stratDateController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.calendar_month_outlined),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('End date'),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black45))),
                    child: TextField(
                      onTap: () {
                        pickdate1(context);
                      },
                      readOnly: true,
                      controller: endDateController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.calendar_month_outlined),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: GestureDetector(
                    onTap: () {
                      walletprovider.getBillingHistory(
                          context: context,
                          setState: setState,
                          startDate: startDate,
                          endDate: endDate);
                    },
                    child: Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(
                          gradient: ColorConstant().bottonColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Text(
                          'GET BILL',
                          style: TextConstant().buttonText,
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: (walletprovider.getBillingListModel?.data ?? []).isEmpty
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transactions',
                          style: TextConstant().lableText,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Table(
                          columnWidths: {
                            0: FixedColumnWidth(
                                90.0), // Fixed width for the first column
                            1: FlexColumnWidth(), // Fractional width for the second column
                            2: FlexColumnWidth(),
                            3: FlexColumnWidth(),
                            4: FlexColumnWidth(), // Flexible width for the third column
                          },
                          children: [
                            TableRow(
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey[200],
                                    borderRadius: BorderRadius.circular(5)),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 5, bottom: 5),
                                    child: Text(
                                      'Date',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Text(
                                      'Debit',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Text('Credit',
                                        style: TextStyle(fontSize: 16)),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Text('Balance',
                                        style: TextStyle(fontSize: 16)),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 5, bottom: 5),
                                    child: Text(''),
                                  ))
                                ]),
                          ],
                        ),
                      ]..addAll([
                          ...?walletprovider.getBillingListModel?.data!
                              .map((data) {
                            return Table(
                              // defaultColumnWidth: FlexColumnWidth(150),
                              columnWidths: {
                                0: FixedColumnWidth(
                                    90.0), // Fixed width for the first column
                                1: FlexColumnWidth(), // Fractional width for the second column
                                2: FlexColumnWidth(),
                                3: FlexColumnWidth(),
                                4: FlexColumnWidth(), // Flexible width for the third column
                              },
                              children: [
                                const TableRow(
                                  children: [
                                    SizedBox(height: 10.0),
                                    SizedBox(height: 10.0),
                                    SizedBox(height: 10.0),
                                    SizedBox(height: 10.0),
                                    SizedBox(height: 10.0),
                                  ],
                                ),
                                TableRow(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    children: [
                                      TableCell(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 10, bottom: 10),
                                        child: Text(DateFormat('dd MMM').format(
                                            data.createdAt ?? DateTime.now())),
                                      )),
                                      TableCell(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                            data.transactionType == 'DEBITED'
                                                ? '\u20B9${data.amount}'
                                                : ''),
                                      )),
                                      TableCell(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                            data.transactionType == 'CREDITED'
                                                ? '\u20B9${data.amount}'
                                                : ''),
                                      )),
                                      TableCell(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                            '\u20B9${data.balanceAmount ?? 0}'),
                                      )),
                                      TableCell(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 10, bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (data.transactionType ==
                                                'DEBITED') {
                                              walletprovider
                                                  .getBillingDetails(
                                                      context: context,
                                                      setState: setState,
                                                      billingId: data.id,
                                                      orderId: data.orderItemId,
                                                      subscriptionId: data
                                                          .scheduleSubscriptionId)
                                                  .then((value) {
                                                showdailog();
                                              });
                                            } else if (data.transactionType ==
                                                'CREDITED') {
                                              showRechargeDialog(
                                                  '${data.amount}',
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(data.createdAt ??
                                                          DateTime.now()),
                                                  '');
                                            }
                                          },
                                          child: Text(
                                            'DETAILS',
                                            style: TextStyle(
                                                color: ColorConstant()
                                                    .containerColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ))
                                    ]),
                              ],
                            );
                          }).toList(),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                                child: GestureDetector(
                              child: Container(
                                height: 35,
                                width: 120,
                                decoration: BoxDecoration(
                                    gradient: ColorConstant().bottonColor,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                  child: Text(
                                    'SEND BILL',
                                    style: TextConstant().buttonText,
                                  ),
                                ),
                              ),
                            )),
                          )
                        ]),
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
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2021), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().add(Duration(days: 30)));

    if (pickedDate != null) {
      startDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          'startdate$startDate'); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        stratDateController.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  Future pickdate1(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        // currentDate: DateTime.now().add(Duration(days: 1)),
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2021), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().add(Duration(days: 30)));

    if (pickedDate != null) {
      endDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          'startdate$startDate'); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        endDateController.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  showRechargeDialog(String amount, String date, String remark) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            actionsAlignment: MainAxisAlignment.center,
            content: Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Recharge Details',
                    style: TextConstant().lableText,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Table(
                    // defaultColumnWidth: FixedColumnWidth(70),
                    children: [
                      TableRow(children: [
                        Text(
                          'Recharge Amount',
                          style: TextConstant().subtitleText,
                        ),
                        Text(
                          ': \u20B9 $amount',
                          style: TextConstant().subtitleText,
                        ),
                      ]),
                      const TableRow(children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          'Recharge date',
                          style: TextConstant().subtitleText,
                        ),
                        Text(
                          ': $date',
                          style: TextConstant().subtitleText,
                        ),
                      ]),
                      const TableRow(children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          'Remark',
                          style: TextConstant().subtitleText,
                        ),
                        Text(
                          ': $remark',
                          style: TextConstant().subtitleText,
                        ),
                      ])
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 35,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: ColorConstant().bottonColor),
                    child: Center(
                        child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ))),
              )
            ],
          );
        });
  }

  void showdailog() {
    showDialog(
        context: context,
        builder: (context) {
          var data = walletprovider.getBillingDetailModel?.data;
          DateTime date =
              DateTime.fromMillisecondsSinceEpoch(data?.deliveryDate ?? 0);
          return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            actionsAlignment: MainAxisAlignment.center,
            content: Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Text(
                    'Delivery date ${DateFormat('dd MMM yyyy').format(date)}',
                    style: TextConstant().lableText,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              'https://tse4.mm.bing.net/th?id=OIP.8vtlhiG0ozEzXbDlax-91gAAAA&pid=Api&P=0&h=220',
                              width: 70,
                              height: 70,
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
                              data?.productName ?? '',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Table(
                              defaultColumnWidth: FixedColumnWidth(70),
                              children: [
                                TableRow(children: [
                                  Text(
                                    'Price',
                                    style: TextConstant().subtitleText,
                                  ),
                                  Text(
                                    ': \u20B9 ${data?.amountWithDelivery}',
                                    style: TextConstant().subtitleText,
                                  ),
                                ]),
                                const TableRow(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    'Quentity',
                                    style: TextConstant().subtitleText,
                                  ),
                                  Text(
                                    ': ${data?.quantity}',
                                    style: TextConstant().subtitleText,
                                  ),
                                ])
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // Container(
                      //   child: const Row(
                      //     // mainAxisSize: MainAxisSize.max,
                      //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Icon(
                      //         Icons.history_outlined,
                      //         size: 22,
                      //       ),
                      //       SizedBox(
                      //         width: 5,
                      //       ),
                      //       Text(
                      //         'Refunded',
                      //         style: TextStyle(fontSize: 12),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 35,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: ColorConstant().bottonColor),
                    child: Center(
                        child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ))),
              )
            ],
          );
        });
  }
}
