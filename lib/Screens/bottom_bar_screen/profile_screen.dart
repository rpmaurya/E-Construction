import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Screens/Subscription_Management_Screen/MySubscription_screen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/edit_profile_screen.dart';
import 'package:e_basket/Screens/login_screen/login_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthProvider authProvider = AuthProvider();
  bool value = false;
  bool ringbell = false;
  bool whatsapp = false;
  bool sms = false;
  bool email = false;
  bool notification = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authProvider.getUserById(context: context, setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text('My Account'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: -20),
                        leading: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromRGBO(0, 0, 0, 0.5)),
                              borderRadius: BorderRadius.circular(50)),
                          // height: 120,
                          // width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              fit: BoxFit.fill,
                              'https://www.mmagyms.net/wp-content/uploads/2020/01/Personal-Trainer-Packages.png',
                            ),
                          ),
                        ),
                        title: Text(
                          '${authProvider.userModel?.data?.firstName} ${authProvider.userModel?.data?.lastName}',
                          style: TextConstant().titleText,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authProvider.userModel?.data?.mobileNo ?? '000',
                              style: TextConstant().subtitleText,
                            ),
                            Text(
                              authProvider.userModel?.data?.email ?? '',
                              style: TextConstant().subtitleText,
                            )
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfileScreen(
                                          userId:
                                              authProvider.userModel?.data?.id,
                                        )));
                          },
                          child: Container(
                            width: 60,
                            height: 35,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstant().containerColor),
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                                child: Text(
                              'Edit',
                              style: TextStyle(
                                  color: ColorConstant().textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            )),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Deleviry Adress',
                        style: TextConstant().titleText,
                      ),
                      subtitle: Text(
                        'H-15,Rise tower,Sector- 62,Noida uttar pradesh ',
                        style: TextConstant().subtitleText,
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MysubscriptionScreen())).then((value) {
                          if (value == true) {
                            setState(() {});
                          }
                        });
                      },
                      child: listItem(Icons.calendar_month, 'My Subscription'),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {},
                      child:
                          listItem(Icons.content_paste_outlined, 'My Orders'),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {},
                      child: listItem(Icons.wallet_outlined, 'My Wallet'),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {},
                      child: listItem(Icons.payment_outlined, 'My Payments'),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {},
                      child: listItem(Icons.wallet_outlined, 'Auto Recharge'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Alerts',
                style: TextConstant().lableText,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    aletItem(
                        Icon(
                          Icons.notifications,
                          color: Color(0xFFBF5F0B),
                        ),
                        'Ring the bell',
                        ringbell, (value) {
                      setState(() {
                        ringbell = value;
                      });
                    }),
                    Divider(),
                    aletItem(
                        Image.asset(
                          'assets/images/whatsapp (1).png',
                          color: Color(0xFFBF5F0B),
                          width: 22,
                          height: 22,
                        ),
                        'WhatsApp notifications',
                        whatsapp, (value) {
                      setState(() {
                        whatsapp = value;
                      });
                    }),
                    Divider(),
                    aletItem(
                        Icon(
                          Icons.sms,
                          color: Color(0xFFBF5F0B),
                        ),
                        'SMS notifications',
                        sms, (value) {
                      setState(() {
                        sms = value;
                      });
                    }),
                    Divider(),
                    aletItem(
                        Icon(
                          Icons.email,
                          color: Color(0xFFBF5F0B),
                        ),
                        'Email notifications',
                        email, (value) {
                      setState(() {
                        email = value;
                      });
                    }),
                    Divider(),
                    aletItem(
                        Icon(
                          Icons.notifications,
                          color: Color(0xFFBF5F0B),
                        ),
                        'Push notifications',
                        notification, (value) {
                      setState(() {
                        notification = value;
                      });
                    }),
                    // Theme(
                    //   data: ThemeData(useMaterial3: false),
                    //   child: Transform.scale(
                    //     child: SwitchListTile(
                    //         dense: true,
                    //         activeColor: Color(0xFFBF5F0B),
                    //         activeTrackColor:
                    //             Color.fromARGB(252, 242, 199, 161),
                    //         inactiveTrackColor: Colors.grey,
                    //         value: value,
                    //         onChanged: (value2) {
                    //           setState(() {
                    //             value = value2;
                    //           });
                    //         },
                    //         secondary: CircleAvatar(
                    //             backgroundColor:
                    //                 Color.fromARGB(252, 242, 199, 161),
                    //             child: Icon(
                    //               Icons.abc_outlined,
                    //               color: Color(0xFFBF5F0B),
                    //             )),
                    //         title: Text('data')),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
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

  aletItem(Widget icon, String title, bool selectedValue,
      void Function(bool)? onChanged) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Container(
          child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Color.fromARGB(252, 242, 199, 161), child: icon),
        title: Text(title),
        trailing: Transform.scale(
          scale: 1.3,
          child: Switch(
              activeColor: Color(0xFFBF5F0B),
              activeTrackColor: Color.fromARGB(252, 242, 199, 161),
              inactiveTrackColor: Colors.grey,
              value: selectedValue,
              onChanged: onChanged),
        ),
      )),
    );
  }
}
