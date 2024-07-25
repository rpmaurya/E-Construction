import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:e_basket/Screens/help_screens/FAQ_Screen.dart';
import 'package:e_basket/Screens/help_screens/contactus_screen.dart';
import 'package:e_basket/common_file/location_picker.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomBarScreen()),
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text('Help'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(252, 242, 199, 161),
                    child: Icon(
                      Icons.question_answer_rounded,
                      color: Color(0xFFBF5F0B),
                    )),
                title: Text('Recent Chat'),
                subtitle: Text('0 unread messages'),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                'Chat with us',
                style: TextConstant().lableText,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             MysubscriptionScreen())).then((value) {
                      //   if (value == true) {
                      //     setState(() {});
                      //   }
                      // });
                    },
                    child: listItem(Icons.today_rounded, "Today's deliveries"),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Orderscreen(
                      //               backPage: true,
                      //             )));
                    },
                    child: listItem(
                        Icons.content_paste_outlined, "Yesterday's deliveries"),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => WalletScreen(
                      //               sendOnPage: 'mySubscription',
                      //             )));
                    },
                    child: listItem(Icons.edit_calendar, 'Others'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                'Other queries',
                style: TextConstant().lableText,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FaqScreen()));
                    },
                    child: listItem(Icons.mark_unread_chat_alt_rounded, 'FAQ'),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Orderscreen(
                      //               backPage: true,
                      //             )));
                    },
                    child: listItem(
                        Icons.content_paste_outlined, 'Terms and Conditions'),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => WalletScreen(
                      //               sendOnPage: 'mySubscription',
                      //             )));
                    },
                    child:
                        listItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {},
                    child: listItem(
                        Icons.file_copy_outlined, 'Offer Term & Conditions'),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactusScreen()));
                    },
                    child: listItem(Icons.phone_iphone_outlined, 'Contact Us'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  listItem(IconData icon, String title) {
    return Container(
        child: ListTile(
      leading: CircleAvatar(
          backgroundColor: Color.fromARGB(252, 242, 199, 161),
          child: Icon(
            icon,
            color: Color(0xFFBF5F0B),
          )),
      title: Text(title),
      trailing: Icon(Icons.keyboard_arrow_right),
    ));
  }
}
