import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/common_file/common_button.dart';
import 'package:e_basket/common_file/custom_textfield.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
   final int? userId;
  const EditProfileScreen({super.key,this.userId});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ColorConstant().gradientColor)),
        child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    CustomTextfield(
                      fillColor: Colors.white,
                      controller: authProvider.firstName,
                      hintText: 'Enter First Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Field';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      fillColor: Colors.white,
                      controller:authProvider.lastName,
                      hintText: 'Enter Last Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Field';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      fillColor: Colors.white,
                      controller: authProvider.email,
                      hintText: 'Enter Your Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Field';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                        onselect: () {
                          if (_formkey.currentState!.validate()) {
                            authProvider.editProfileById(context: context, setState: setState);
                          }
                        },
                        text: 'Submit')
                  ],
                ),
              ),
            )),
      ),
    );
  }
}