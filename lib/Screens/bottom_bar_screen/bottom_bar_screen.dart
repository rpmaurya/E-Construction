import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Screens/bottom_bar_screen/OrderScreen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/dashboard_screen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/help_screen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/wallet_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:flutter/material.dart';

class BottomBarScreen extends StatefulWidget {
  final int? userid;
  const BottomBarScreen({super.key, this.userid});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  ColorConstant colorConstant = ColorConstant();
  AuthProvider authProvider = AuthProvider();
  int? userId;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authProvider.getUserById(
        context: context, setState: setState, userId: widget.userid);
  }

  List<Widget> widgetOptions = [
    DashboardScreen(),
    Orderscreen(),
    WalletScreen(),
    HelpScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: colorConstant.bottonColor,
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.white70,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconSize: 28,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.white24),
            BottomNavigationBarItem(
                icon: Icon(Icons.content_paste_outlined),
                label: 'Orders',
                backgroundColor: Color.fromRGBO(255, 255, 255, 1)),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet_outlined),
              label: 'Wallet',
              // backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_outline_outlined),
              label: 'Help',
              // backgroundColor: Colors.white,s
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
