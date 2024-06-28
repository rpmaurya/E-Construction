import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropdown extends StatefulWidget {
  String? hintText;
  final String? Function(String?)? validator;
  final List<dynamic> items;
  // final void Function()? onChanged;
  final ValueChanged<String> onChanged;

  CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
    this.validator,
    required this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool isOpen = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: TextFormField(
            controller: controller,
            readOnly: true,
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
                hintStyle: TextConstant().filterText,
                suffixIcon: isOpen
                    ? Icon(Icons.keyboard_arrow_up)
                    : Icon(Icons.keyboard_arrow_down)),
            // validator: widget.validator,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select Item';
              }
              print({'validator value': value});

              return null;
            },
            onChanged: widget.onChanged,
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
          ),
        ),
        if (isOpen)
          Visibility(
            visible: isOpen,
            child: Container(
              constraints: BoxConstraints(maxHeight: 250),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView(
                scrollDirection: Axis.vertical,
                // physics: PageScrollPhysics(),
                primary: true,
                shrinkWrap: true,
                children: widget.items
                    .map((e) => InkWell(
                          onTap: () {
                            widget.onChanged(e);

                            setState(() {
                              // widget.selectedValue = e;
                              // print({'Selected value..': widget.selectedValue});
                              isOpen = false;
                              controller.text = e;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(2),
                            decoration: controller.text == e
                                ? BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFFBF5F0B)),
                                    borderRadius: BorderRadius.circular(10))
                                : BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e),
                                  if (controller.text == e) Icon(Icons.check)
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
      ],
    );
  }
}
