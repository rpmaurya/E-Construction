import 'package:e_basket/Providers/WalletProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RechargeHistoryScreen extends StatefulWidget {
  const RechargeHistoryScreen({super.key});

  @override
  State<RechargeHistoryScreen> createState() => _RechargeHistoryScreenState();
}

class _RechargeHistoryScreenState extends State<RechargeHistoryScreen> {
  Walletprovider walletprovider = Walletprovider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    walletprovider.geRechargeHistory(context: context, setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('Recharge History'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/bars-filter-icon.webp',
                fit: BoxFit.fill,
                color: Colors.black,
                height: 20,
                width: 24,
              ))
        ],
      ),
      body: (walletprovider.rechargeHistoryModel?.data ?? []).isEmpty
          ? Center(
              child: Text('No Data Found'),
            )
          // : Padding(
          //     padding: const EdgeInsets.all(15.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(DateFormat('MMMM yyyy').format(DateTime.now())),
          //         SizedBox(
          //           height: 10,
          //         ),
          //         Container(
          //           padding: EdgeInsets.all(10),
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(3)),
          //           child: Column(
          //               children: []..addAll([
          //                   ...walletprovider.rechargeHistoryModel!.data!
          //                       .map((getdata) {
          //                     String formatedDate =
          //                         DateFormat('MMM dd yyyy HH:mm a').format(
          //                             DateTime.fromMillisecondsSinceEpoch(
          //                                 getdata.createdAt ?? 0));
          //                     return Column(
          //                       children: [
          //                         Padding(
          //                           padding: const EdgeInsets.all(8.0),
          //                           child: Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Text(
          //                                     'Initiated on $formatedDate',
          //                                     style: TextStyle(
          //                                         color: Colors.black,
          //                                         fontSize: 14,
          //                                         fontWeight: FontWeight.w500),
          //                                   ),
          //                                   Text(
          //                                     'Transaction Type: Recharge once',
          //                                     style: TextStyle(fontSize: 14),
          //                                   )
          //                                 ],
          //                               ),
          //                               Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Text(
          //                                     getdata.status ?? '',
          //                                     style: TextStyle(
          //                                         fontWeight: FontWeight.w500,
          //                                         fontSize: 14,
          //                                         color: getdata.status ==
          //                                                 'Success'
          //                                             ? Colors.green
          //                                             : Colors.red),
          //                                   ),
          //                                   Text(
          //                                     '\u20B9${getdata.amount}',
          //                                     style: TextStyle(
          //                                         fontWeight: FontWeight.w500),
          //                                   )
          //                                 ],
          //                               )
          //                             ],
          //                           ),
          //                         ),
          //                       ],
          //                     );
          //                   })
          //                 ])),
          //         )
          //       ],
          //     ),
          //   ),

          : SingleChildScrollView(
              child: Column(
                // physics: NeverScrollableScrollPhysics(),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 15,
                    ),
                    child: Text(DateFormat('MMMM yyyy').format(DateTime.now())),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 9,
                      child: ListView.separated(
                          shrinkWrap: true,
                          // padding: EdgeInsets.all(10),
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 0.3,
                              color: Colors.black26,
                            );
                          },
                          itemCount: walletprovider
                                  .rechargeHistoryModel?.data?.length ??
                              0,
                          itemBuilder: (context, index) {
                            var getdata =
                                walletprovider.rechargeHistoryModel?.data ?? [];
                            String formatedDate =
                                DateFormat('MMM dd yyyy HH:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        getdata[index].createdAt ?? 0));
                            return Container(
                              // height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Initiated on $formatedDate',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              'Transaction Type: Recharge once',
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              getdata[index].status ?? '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color:
                                                      getdata[index].status ==
                                                              'Success'
                                                          ? Colors.green
                                                          : Colors.red),
                                            ),
                                            Text(
                                              '\u20B9${getdata[index].amount}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  historyItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Initiated on '), Text('Transaction Type:')],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Failed'), Text('\u20B91500')],
        )
      ],
    );
  }
}
