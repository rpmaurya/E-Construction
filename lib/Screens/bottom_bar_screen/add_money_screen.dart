import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';

class AddMoneyScreen extends StatefulWidget {
  final String getAmount;
  const AddMoneyScreen({super.key, required this.getAmount});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('Add Money'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Balance',
                    style: TextConstant().lableText,
                  ),
                  Text(
                    '\u20B9 ${widget.getAmount}',
                    style: TextConstant().cardtitleText,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Payment Option',
                style: TextConstant().cardTitle,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(252, 242, 199, 161),
                        child: Image.asset(
                          'assets/images/bhim_upi.png',
                          color: Color(0xFFBF5F0B),
                          width: 24,
                          height: 24,
                        )),
                    title: Text('UPI Apps'),
                  ),
                  Row(
                    children: [],
                  ),
                  Divider(),
                  GestureDetector(
                    child: listItem(
                        Image.asset(
                          'assets/images/bhim_upi.png',
                          color: Color(0xFFBF5F0B),
                          width: 24,
                          height: 24,
                        ),
                        'Other UPI Options'),
                  ),
                  Divider(),
                  GestureDetector(
                    child: listItem(
                        Icon(
                          Icons.wallet_sharp,
                          color: Color(0xFFBF5F0B),
                        ),
                        'Credit / Debit Card'),
                  ),
                  Divider(),
                  GestureDetector(
                    child: listItem(
                        Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Color(0xFFBF5F0B),
                        ),
                        'Wallets'),
                  ),
                  Divider(),
                  GestureDetector(
                    child: listItem(
                        Icon(
                          Icons.account_balance_sharp,
                          color: Color(0xFFBF5F0B),
                        ),
                        'Net Banking'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  listItem(Widget icon, String title) {
    return Container(
        child: ListTile(
      leading: CircleAvatar(
          backgroundColor: Color.fromARGB(252, 242, 199, 161), child: icon),
      title: Text(title),
      trailing: Icon(Icons.keyboard_arrow_right),
    ));
  }
}
