import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class OrderSuccessfulScreen extends StatefulWidget {
  const OrderSuccessfulScreen({
    super.key,
  });

  @override
  State<OrderSuccessfulScreen> createState() => _OrderSuccessfulScreenState();
}

class _OrderSuccessfulScreenState extends State<OrderSuccessfulScreen> {
  String defaultdate =
      DateFormat.yMMMEd().format(DateTime.now().add(Duration(days: 1)));
  bool forAndorid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
        title: Text('Your Order is Placed'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
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
                      'Your Order will be delivered on $defaultdate',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const ListTile(
                      leading: Icon(Icons.badge),
                      title: Text('Hang a bag on your door'),
                      subtitle: Text(
                        "Don't forget to hang a bag on your door every day. This is ensure that the items will remain fresh and intact",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Theme(
                data: ThemeData(useMaterial3: false),
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
                  trailing: Transform.scale(
                    scale: 1.4,
                    child: Switch(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
