import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SuccessSubscribeScreen extends StatefulWidget {
  final DateTime startedDate;
  const SuccessSubscribeScreen({super.key, required this.startedDate});

  @override
  State<SuccessSubscribeScreen> createState() => _SuccessSubscribeScreenState();
}

class _SuccessSubscribeScreenState extends State<SuccessSubscribeScreen> {
  bool forAndorid = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String startedDate = DateFormat.yMMMMd().format(widget.startedDate);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close)),
        title: Text('Your Subscription Successfull'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/e-construction.png',
                      scale: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your Subscription will start from $startedDate',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Please Recharge Your Wallet for uninterrupted service',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Feedback',
                style: TextConstant().lableText,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Center(child: Text('How was your shoping exprience')),
                    SizedBox(
                      height: 10,
                    ),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Alert',
                style: TextConstant().lableText,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/whatsapp.png'),
                    )),
                title: Text(
                  'whatsApp Alert',
                  style: TextConstant().lableText,
                ),
                subtitle: Text(
                  'This will help you not miss your order due to low balance',
                  style: TextConstant().subtitleText,
                ),
                trailing: Switch(
                    trackOutlineColor: WidgetStateColor.transparent,
                    // activeTrackColor: Colors.yellow,
                    // activeColor: ColorConstant().containerColor,
                    value: forAndorid,
                    onChanged: (value) {
                      setState(() {
                        forAndorid = value;
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'How its works',
                style: TextConstant().lableText,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    message(
                        Icon(
                          Icons.badge,
                          color: Colors.orange,
                        ),
                        'Hang a bag on your door',
                        "Dont't forgot hang a bag on your door everyday.This will ensure that the items will remain fresh and intact"),
                    Divider(),
                    message(
                        Icon(
                          Icons.wallet,
                          color: Colors.deepOrange[300],
                        ),
                        'Prepad Wallet Service',
                        "Dont't forgot hang a bag on your door everyday.This will ensure that the items will remain fresh and intact"),
                    Divider(),
                    message(
                        Icon(
                          Icons.monetization_on,
                          color: Colors.deepOrangeAccent,
                        ),
                        'Reserve Money',
                        "Dont't forgot hang a bag on your door everyday.This will ensure that the items will remain fresh and intact")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  message(Widget icon, String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextConstant().cardTitle,
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        )
      ],
    );
  }
}
