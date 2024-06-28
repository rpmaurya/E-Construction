import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Screens/login_screen/login_screen.dart';
import 'package:e_basket/common_file/common_button.dart';
import 'package:e_basket/common_file/common_screen.dart';
import 'package:e_basket/common_file/custom_dropdown.dart';
import 'package:e_basket/common_file/custom_location.dart';
import 'package:e_basket/common_file/location_picker.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String baseurl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const kGoogleApiKey = "AIzaSyDJqgTlQ5Z9DKssm1Fh-lzjlQXURfvkga0";
  TextEditingController _controller = TextEditingController();
  @override

  // RegisterController controller = RegisterController();
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context, listen: false);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // CommonScreen(),
                const SizedBox(
                  height: 60,
                ),
                Center(
                    child: Text(
                  'E-Construction',
                  style: TextConstant().logoText,
                )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'User Registration',
                  style: GoogleFonts.roboto(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant().textColor),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    controller: authProvider.firstNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.manage_accounts),
                      hintText: 'First Name',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5))),
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter First Name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    controller: authProvider.lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.manage_accounts),
                      hintText: 'Last Name',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5))),
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter last Name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    controller: authProvider.userEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'Email Id',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5))),
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    validator: (value) {
                      const pattern =
                          r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                      final regex = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'Enter valid email id';
                      } else if (!regex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 45,
                  // width: size.width,
                  margin: EdgeInsets.only(left: 40, right: 40),

                  child: IntlPhoneField(
                    controller: authProvider.phoneNumber,
                    flagsButtonPadding: EdgeInsets.all(8.0),
                    keyboardType: TextInputType.phone,
                    dropdownIconPosition: IconPosition.trailing,
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      // setState(() {
                      //   controller.number = phone.number;
                      // });
                      print(phone.number);
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5))),
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'kj,n,n,k';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // SizedBox(height: 160, child: CustomLocation()),
                // SizedBox(height: 60, child: LocationPicker()),
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: CustomDropdown(
                      hintText: 'select location',
                      items: [
                        'fgdffg',
                        'ghghjhj',
                        'ghjjhjkjk',
                        'tfgfg',
                        'fhgfhjghj',
                        'ghghjjh',
                        'fgdffg',
                        'ghghjhj',
                        'ghjjhjkjk',
                        'tfgfg',
                        'fhgfhjghj',
                        'ghghjjh'
                      ],
                      onChanged: (value) {}),
                ),
                SizedBox(
                  height: 20,
                ),
                CommonButton(
                    onselect: () {
                      if (_formKey.currentState!.validate()) {
                        authProvider.registerUser(
                            context: context, setState: setState);
                      }
                    },
                    text: 'REGISTER'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an Account ?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Login',
                          style: TextConstant().textStyle,
                        ))
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        child: Image.asset('assets/images/logo_image.png'),
      ),
    );
  }

  // Future<Null> displayPrediction(Prediction p) async {
  //   PlacesDetailsResponse detail =
  //       await _places.getDetailsByPlaceId(p.placeId!);

  //   var placeId = p.placeId;
  //   double lat = detail.result.geometry!.location.lat;
  //   double lng = detail.result.geometry!.location.lng;

  //   // var address = await Geocoder.local.findAddressesFromQuery(p.description);

  //   print(lat);
  //   print(lng);
  // }
}
