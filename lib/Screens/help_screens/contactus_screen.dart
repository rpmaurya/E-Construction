import 'dart:io';
import 'dart:math';

import 'package:e_basket/common_file/common_button.dart';
import 'package:e_basket/common_file/custom_dropdown.dart';
import 'package:e_basket/common_file/custom_dropdown_button.dart';
import 'package:e_basket/common_file/custom_textfield.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ContactusScreen extends StatefulWidget {
  const ContactusScreen({super.key});

  @override
  State<ContactusScreen> createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  TextEditingController contactemail = TextEditingController();
  TextEditingController contactphone = TextEditingController();
  TextEditingController contactdescripton = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  File? file;
  String _fileName = "No File Chosen";

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('Contact Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: -60,
              child: Container(
                width: size.width,
                height: 280,
                // padding: EdgeInsets.only(bottom: 50),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/Ellipse 46.png',
                      ),
                      fit: BoxFit.cover),
                ),
                child: Center(
                    child: Image.asset(
                  'assets/images/logo.png',
                  height: 70,
                )),
              ),
            ),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 220,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40, bottom: 5),
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(text: 'Email', style: TextConstant().lableText),
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w600))
                    ]),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: CustomTextfield(
                        controller: contactemail, hintText: 'Email')),
                Padding(
                  padding: EdgeInsets.only(left: 40, bottom: 5, top: 5),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(text: 'Phone', style: TextConstant().lableText),
                    TextSpan(
                        text: ' *',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.w600))
                  ])),
                ),
                Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: CustomTextfield(
                        controller: contactphone, hintText: 'Phone No')),
                Padding(
                  padding: EdgeInsets.only(left: 40, bottom: 5, top: 5),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Request Type', style: TextConstant().lableText),
                    const TextSpan(
                        text: ' *',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.w600))
                  ])),
                ),
                Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: CustomDropdown(
                        hintText: 'Option',
                        items: ['dsdd', 'dsfd', 'dsf'],
                        onChanged: (value) {})),
                Padding(
                  padding: EdgeInsets.only(left: 40, bottom: 5, top: 5),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Issue Description',
                        style: TextConstant().lableText),
                    const TextSpan(
                        text: ' *',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.w600))
                  ])),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    controller: contactdescripton,
                    decoration: InputDecoration(
                        hintText: 'Other',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFCDCDCD),
                            // width: 2.0,
                          ),
                        )),
                    maxLines: 4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 5, bottom: 5),
                  child: Text(
                    'Evidance',
                    style: TextConstant().lableText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pickFile();
                        },
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: ColorConstant().bottonColor),
                          child: Center(
                            child: Text(
                              'choose file',
                              style: TextConstant().buttonText,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Text(_fileName))
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: 40, right: 40, top: 20, bottom: 20),
                    child: CommonButton(
                        width: size.width, text: 'Submit', onselect: () {}))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
