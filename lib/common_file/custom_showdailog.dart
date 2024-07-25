import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';

class CustomShowdailog extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget buttons;
  const CustomShowdailog(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.buttons});

  @override
  State<CustomShowdailog> createState() => _CustomShowdailogState();
}

class _CustomShowdailogState extends State<CustomShowdailog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        color: Colors.white,
        constraints: BoxConstraints(maxHeight: 250),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/e-construction.png',
              scale: 2.5,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              // 'Modify Subscription',
              style: TextConstant().lableText,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.subtitle,
              // 'Your can modify your subscription for a time being or permanently',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(
              height: 20,
            ),
            widget.buttons
          ],
        ),
      ),
    );
  }
}
