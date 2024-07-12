import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/common_file/common_button.dart';
import 'package:e_basket/common_file/custom_dropdown.dart';
import 'package:e_basket/common_file/custom_textfield.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:flutter/material.dart';

import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final int? userId;
  const EditProfileScreen({super.key, this.userId});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formkey = GlobalKey<FormState>();

  AuthProvider authProvider = AuthProvider();
  static const kGoogleApiKey = "AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo";
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController lasttNamecontroller = TextEditingController();
  TextEditingController emailidcontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  String? _timeZoneName;
  double? _timeZoneOffset;

  double? lat;
  double? lng;
  @override
  void initState() {
    // authProvider.getLocation(context: context, setState: setState);
    // TODO: implement initState
    super.initState();
    getUser();
    _getTimeZone();
  }

  getUser() async {
    await authProvider
        .getUserById(context: context, setState: setState)
        .then((value) {
      setState(() {
        authProvider.firstName.text =
            authProvider.userModel?.data?.firstName ?? '';
        authProvider.lastName.text =
            authProvider.userModel?.data?.lastName ?? '';
        authProvider.email.text = authProvider.userModel?.data?.email ?? '';
        authProvider.locationController.text =
            authProvider.userModel?.data?.location ?? '';
      });
    });
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
    });
  }

  @override
  Widget build(BuildContext context) {
    // AuthProvider authProvider = Provider.of(context, listen: false);

    return Scaffold(
      // backgroundColor: Colors.blueGrey[50],
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: PageScrollPhysics(),
        child: Center(
          child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),

                  CustomTextfield(
                    width: 260,
                    enabled: true,
                    focusNode: focusNode1,
                    // fillColor: Colors.white,
                    controller: authProvider.firstName,
                    hintText: 'Enter First Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Field';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    width: 260,
                    enabled: true,
                    focusNode: focusNode2,
                    // fillColor: Colors.white,
                    controller: authProvider.lastName,
                    hintText: 'Enter Last Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Field';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    width: 260,
                    enabled: true,
                    focusNode: focusNode3,
                    // fillColor: Colors.white,
                    controller: authProvider.email,
                    hintText: 'Enter Your Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Field';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 260,
                    child: GooglePlaceAutoCompleteTextField(
                      textEditingController: authProvider.locationController,
                      googleAPIKey: kGoogleApiKey,
                      debounceTime: 600,
                      focusNode: focusNode4,

                      countries: ["in", "fr"],
                      itemBuilder: (context, index, Prediction prediction) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              const SizedBox(
                                width: 7,
                              ),
                              Expanded(
                                  child: Text(prediction.description ?? ""))
                            ],
                          ),
                        );
                      },
                      inputDecoration: InputDecoration(
                          // filled: true,
                          // fillColor: Colors.white,
                          hintText: 'Select location',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10)),
                      isLatLngRequired:
                          true, // if you required coordinates from place detail
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
                          authProvider.locationController.text =
                              prediction.description ?? '';
                          authProvider.locationController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: prediction.description?.length ?? 0));
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
                  ),

                  // customautocomplete(authProvider.locationController),
                  // Container(
                  //   // margin: EdgeInsets.only(left: 40, right: 40),
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
                  //               .map((e) =>
                  //                   authProvider.locationId = e.locationId)
                  //               .toSet();
                  //           print({'adreeee': authProvider.locationId});
                  //         });
                  //       }),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  CommonButton(
                      onselect: () {
                        if (_formkey.currentState!.validate()) {
                          authProvider.editProfileById(
                              context: context,
                              setState: setState,
                              lat: lat,
                              lng: lng,
                              timeZone: _timeZoneOffset);
                        }
                      },
                      text: 'Submit')
                ],
              )),
        ),
      ),
      bottomNavigationBar: Container(
        // height: 100,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'assets/images/logo_image.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  // customautocomplete(TextEditingController controller) {
  //   return Container(
  //     child:
  //   );
  // }
}
