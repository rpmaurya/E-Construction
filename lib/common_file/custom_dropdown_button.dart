import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropdownButton extends StatefulWidget {
  String? selecteValue;
  final String? hintText;
  final List<String> itemsList;
  final Function(dynamic)? onChanged;
  final List Function(BuildContext)? selectedItemBuilder;
  CustomDropdownButton(
      {super.key,
      required this.itemsList,
      required this.onChanged,
      required this.hintText,
      this.selecteValue,
      this.selectedItemBuilder});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  bool isSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(left: 10, right: 10),
      // height: 45,
      alignment: Alignment.center,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(8),
      //     color: CustomColors.white,
      //     border: Border.all(color: Colors.black26)),
      child: DropdownButtonFormField(
        style: TextConstant().subtitleText,
        menuMaxHeight: 300,
        decoration: InputDecoration(
          contentPadding: const EdgeInsetsDirectional.symmetric(
              vertical: 10, horizontal: 10),
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
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCDCDCD))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCDCDCD))),
          hintText: widget.hintText,
          enabled: true,
          hintStyle: TextConstant().lableText,
        ),
        isDense: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: widget.itemsList.toSet().map((String item) {
          return DropdownMenuItem(
              value: item,
              child: Container(
                // mar: const EdgeInsets.all(20.0),
                child: Text(item, style: TextConstant().lableText),
              ));
        }).toList(),
        onChanged: (value) {
          widget.selecteValue = value;
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
          print(widget.selecteValue);
        },
        value: widget.selecteValue,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select Item';
          }
          return null;
        },
      ),
    );
  }
}
