import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String? text;
  final double? width;
  final void Function() onselect;
  const CommonButton({super.key, required this.text,required this.onselect,this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onselect,
      child: Container(
        width: width??180,
        height: 45,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: ColorConstant().bottonColor, borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          text.toString(),
          style: TextConstant().buttonText,
        )),
      ),
    );
  }
  }
