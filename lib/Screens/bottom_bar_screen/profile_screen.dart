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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authProvider.getUserById(context: context, setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        title: Text('My Account'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: ColorConstant().containerColor),
                    borderRadius: BorderRadius.circular(10)),
                surfaceTintColor: Colors.white,
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
                        'Sector- 62,Noida up ',
                        style: TextConstant().subtitleText,
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
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
                      leading: Icon(Icons.calendar_month_rounded),
                      title: Text('My Subscription'),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.wallet_giftcard_rounded),
                      title: Text('My Order'),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.wallet),
                      title: Text('My Wallet'),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.payment),
                      title: Text('My Payment'),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.receipt_sharp),
                      title: Text('Auto Recharge'),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                  ],
                ),
              ),
              Card(
                child: GestureDetector(
                  onTap: () {
                    removeData();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void removeData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
