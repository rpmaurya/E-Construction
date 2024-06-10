
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;
  final int? textLength;
  final String? obscuringCharacter;
  final TextInputType? keyboardType;
  final bool? enabled;
  final Widget? suffixIcons;
  final Color? fillColor;

  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator,
      this.obscureText,
      this.maxLines = 1,
      this.minLines = 1,
      this.textLength,
      this.obscuringCharacter,
      this.keyboardType,
      this.suffixIcons,
      this.fillColor,
      this.onChanged,
      this.enabled});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        obscureText: widget.obscureText ?? false,
        controller: widget.controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.textLength),
        ],
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        keyboardType: widget.keyboardType,
        enabled: widget.enabled,
        decoration: InputDecoration(
            suffixIcon: widget.suffixIcons,
            fillColor: widget.fillColor,
            filled: widget.fillColor != null,
            hintText: widget.hintText,
            hintStyle: TextConstant().subtitleText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            // border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            )

            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(12),
            //     borderSide: BorderSide(color: Color(0xFFCDCDCD))),
            ),
        validator: widget.validator,
        onChanged: widget.onChanged,
      ),
    );
  }
}
