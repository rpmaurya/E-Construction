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
    return Container(
      child: showdailog(context, widget.title, widget.subtitle, widget.buttons),
    );
  }

  showdailog(BuildContext context, String title, String subtitle,
      Widget buttons) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              color: Colors.white,
              constraints: BoxConstraints(maxHeight: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/e-construction.png',
                    scale: 2.5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    // 'Modify Subscription',
                    style: TextConstant().lableText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    subtitle,
                    // 'Your can modify your subscription for a time being or permanently',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buttons
                ],
              ),
            ),
          );
        });
  }
}
