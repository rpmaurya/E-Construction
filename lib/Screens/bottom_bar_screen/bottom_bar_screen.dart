import 'package:e_basket/Screens/bottom_bar_screen/dashboard_screen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/explore_screen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/profile_screen.dart';
import 'package:e_basket/Screens/bottom_bar_screen/shoping_cart_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:flutter/material.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  ColorConstant colorConstant = ColorConstant();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    ExploreScreen(),
    ShopingCartScreen(),
    ProfileScreen()
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
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white70,
        elevation: 0,
        backgroundColor: Colors.green[600],
        iconSize: 28,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white24),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
              backgroundColor: Color.fromRGBO(255, 255, 255, 1)),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            // backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
            // backgroundColor: Colors.white,s
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}