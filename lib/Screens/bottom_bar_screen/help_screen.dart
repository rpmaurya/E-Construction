import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:e_basket/common_file/location_picker.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        child: Column(
          children: [
            // CustomLocatioTextfield(),
            // Container(height: 200, child: LocationPicker())
          ],
        ),
      ),
    );
  }
}
