// import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Screens/login_screen/login_screen.dart';
import 'package:e_basket/common_file/common_button.dart';

import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthProvider authProvider = AuthProvider();
  final _formKey = GlobalKey<FormState>();
  String baseurl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  List<Placemark>? address;
  String token = '123456789';
  static const kGoogleApiKey = "AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo";
  final FocusNode _focusNode1 = FocusNode();
  // final FocusNode _focusNode2 = FocusNode();
  String? _timeZoneName;
  double? _timeZoneOffset;

  double? lat;
  double? lng;
  @override
  void initState() {
    // authProvider.getLocation(context: context, setState: setState);
    // _getCurrentLocation();
    _getTimeZone();
    // TODO: implement initState
    super.initState();
  }

  String _printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    // String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }

  double convertDurationToDouble(Duration duration) {
    // Get the total number of hours from the duration
    int totalHours = duration.inHours;

    // Get the remaining minutes and convert to fraction of an hour
    int remainingMinutes = duration.inMinutes.remainder(60);
    double fractionOfHour = remainingMinutes / 60.0;

    // Combine the total hours and fraction of an hour
    double totalHoursWithFraction = totalHours + fractionOfHour;

    return totalHoursWithFraction;
  }

  void _getTimeZone() async {
    DateTime dateTime = DateTime.now();
    String timeZoneName = dateTime.timeZoneName;
    Duration timeZoneOffset = dateTime.timeZoneOffset;
    // String timeZone = _printDuration(timeZoneOffset);
    double timeeeeee = convertDurationToDouble(timeZoneOffset);
    print('double in time...$timeeeeee');
    setState(() {
      _timeZoneName = timeZoneName;
      _timeZoneOffset = timeeeeee;
      print('timezonename...$_timeZoneName');
      print('timezonoffnn...$_timeZoneOffset');
      print(_printDuration(timeZoneOffset));
    });
  }

  // Future<void> getTimeZone(double lat, double lng) async {
  //   final String url =
  //       'https://maps.googleapis.com/maps/api/timezone/json?location=$lat,$lng&timestamp=${DateTime.now().millisecondsSinceEpoch ~/ 1000}&key=$kGoogleApiKey';

  //   // final response = await http.get(Uri.parse(url));
  //   try {
  //     // Response<dynamic>? response = await _http?.get(url);
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       print({'response': data});

  //       final String timeZoneId = data['timeZoneId'];
  //       final String timeZoneName = data['timeZoneName'];
  //       print('Time Zone ID: $timeZoneId');
  //       print('Time Zone Name: $timeZoneName');
  //     } else {
  //       throw Exception('Failed to load timezone');
  //     }
  //   } catch (e) {
  //     print('error:$e');
  //   }
  // }

  // Future _getCurrentLocation() async {
  //   try {
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       print("No permission, requesting one");
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.deniedForever) {
  //         return Future.error('Location Not Available');
  //       }
  //     }
  //     print("Found permission to get location");
  //     final location = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     print({'locatio': location.timestamp});

  //     List<Placemark> addresses =
  //         await placemarkFromCoordinates(location.latitude, location.longitude);

  //     setState(() {
  //       address = addresses!;
  //     });
  //   } catch (e) {
  //     print({'object': e});
  //   }
  // }

  @override

  // RegisterController controller = RegisterController();
  Widget build(BuildContext context) {
    // AuthProvider authProvider = Provider.of(context, listen: false);

    var size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: PageScrollPhysics(),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CommonScreen(),
              const SizedBox(
                height: 100,
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
                    setState(() {
                      // controller.number = phone.number;
                      print(phone.number);
                    });
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
              const SizedBox(
                height: 10,
              ),

              customautocomplete(authProvider.locationController),

              // SizedBox(height: 160, child: CustomLocation()),
              // SizedBox(height: 60, child: LocationPicker()),
              // Container(
              //   margin: EdgeInsets.only(left: 40, right: 40),
              //   child: CustomDropdown(
              //       hintText: 'select location',
              //       items: (authProvider.locationModel?.data ?? [])
              //           .map(
              //             (e) => '${e.location}',
              //           )
              //           .toList(),
              //       onChanged: (value) {
              //         setState(() {
              //           authProvider.locationModel?.data!
              //               .where((e) => e.location == value)
              //               .map(
              //                   (e) => authProvider.locationId = e.locationId)
              //               .toSet();
              //           print({'adreeee': authProvider.locationId});
              //         });
              //       }),
              // ),

              // Container(
              //   margin: EdgeInsets.only(left: 40, right: 40),
              //   child: CustomDropdown(
              //       hintText: 'select',
              //       items: (address ?? [])
              //           .map((e) =>
              //               '${e.street},${e.subLocality},${e.locality},${e.administrativeArea}')
              //           .toList(),
              //       onChanged: (value) {}),
              // ),

              SizedBox(
                height: 20,
              ),
              CommonButton(
                  onselect: () {
                    if (_formKey.currentState!.validate()) {
                      authProvider.registerUser(
                          context: context,
                          setState: setState,
                          lat: lat,
                          lng: lng,
                          timezone: _timeZoneOffset);
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
                height: 100,
              )
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        // height: 100,
        width: size.width,
        child: Image.asset(
          'assets/images/logo_image.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  customautocomplete(TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: kGoogleApiKey,
        debounceTime: 800,
        focusNode: _focusNode1,
        boxDecoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10)),
        countries: ["in", "fr"],
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            decoration: BoxDecoration(
                // color: Colors.white,
                ),
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 7,
                ),
                Expanded(child: Text("${prediction.description ?? ""}"))
              ],
            ),
          );
        },
        inputDecoration: InputDecoration(
            hintText: 'Select location',
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
        isLatLngRequired: true, // if you required coordinates from place detail
        getPlaceDetailWithLatLng: (Prediction prediction) async {
          // this method will return latlng with place detail
          print("placeDetails" + prediction.lng.toString());
          print("placeDetails" + prediction.lat.toString());
          if (prediction.lat != null && prediction.lng != null) {
            lat = double.tryParse('${prediction.lat}') ?? 0.0;
            lng = double.tryParse('${prediction.lng}') ?? 0.0;
            // await getTimeZone(lat, lng);
            // print('object...time');
          }
        },
        itemClick: (Prediction prediction) {
          setState(() {
            controller.text = prediction.description ?? '';
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description?.length ?? 0));
          });
        },
        seperatedBuilder: Divider(
          height: 0,
        ),
        // want to show close icon
        isCrossBtnShown: true,
        // optional container padding
        containerHorizontalPadding: 10,
      ),
    );
  }
}
