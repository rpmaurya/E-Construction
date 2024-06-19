import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';

class CustomDatepickercard extends StatefulWidget {
  final String datetext;
  const CustomDatepickercard({super.key, required this.datetext});

  @override
  State<CustomDatepickercard> createState() => _CustomDatepickercardState();
}

class _CustomDatepickercardState extends State<CustomDatepickercard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        minTileHeight: 40,
        // visualDensity: VisualDensity.standard,
        leading: const Icon(
          Icons.calendar_month,
          size: 30,
        ),
        title: Text(
          'Subscription Start Date',
          style: TextConstant().subtitleText,
        ),
        subtitle: Text(
          widget.datetext,
          style: TextConstant().lableText,
        ),
        trailing: Icon(Icons.keyboard_arrow_down),
      ),
      // child: Row(
      //   children: [
      //     Icon(
      //       Icons.calendar_month,
      //       size: 30,
      //     ),
      //     Expanded(
      //       child: Column(
      //         children: [Text('data'), Text(widget.datetext)],
      //       ),
      //     ),
      //     Icon(Icons.keyboard_arrow_down)
      //   ],
      // ),
    );
  }
}
