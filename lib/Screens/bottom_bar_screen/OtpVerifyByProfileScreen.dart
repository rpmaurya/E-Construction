import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:e_basket/common_file/common_button.dart';
import 'package:e_basket/common_file/common_screen.dart';
import 'package:e_basket/models/user-model.dart';
import 'package:e_basket/utils/sharepreferences_file.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Otpverifybyprofilescreen extends StatefulWidget {
  final UserModel? editResp;
  const Otpverifybyprofilescreen({super.key, this.editResp});

  @override
  State<Otpverifybyprofilescreen> createState() =>
      _OtpverifybyprofilescreenState();
}

class _OtpverifybyprofilescreenState extends State<Otpverifybyprofilescreen> {
  final _formKey = GlobalKey<FormState>();
  AuthProvider authProvider = AuthProvider();
  UserModel? getdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata = widget.editResp;
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // CommonScreen(),
              Center(
                child: SizedBox(
                  width: size.width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Text(
                        'Otp Verification',
                        style: GoogleFonts.montserrat(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        'Otp sent on your Email',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: PinCodeTextField(
                          keyboardType: TextInputType.number,
                          enableActiveFill: true,
                          cursorColor: Colors.black,
                          appContext: context,
                          length: 4,
                          onChanged: (value) {
                            // Handle changes in the OTP input
                            print(value);
                          },
                          onCompleted: (value) {
                            // Handle when the user completes entering the OTP
                            print("Completed: $value");
                          },
                          // You can customize the appearance of the input field
                          pinTheme: PinTheme(
                              borderWidth: 1,
                              activeBorderWidth: 1,
                              inactiveBorderWidth: 1,
                              selectedFillColor: Colors.white,
                              shape: PinCodeFieldShape.box,
                              inactiveFillColor: Colors.white,
                              activeFillColor: Colors.white,
                              inactiveColor: Colors.grey,
                              activeColor: Color.fromRGBO(0, 0, 0, 0.5),
                              borderRadius: BorderRadius.circular(10)),
                          controller: authProvider.otpController,
                          // Validator function for OTP
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the OTP';
                            }
                            if (value.length != 4) {
                              return 'OTP must be 4 digits long';
                            }
                            // You can add more custom validation here if needed
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: CommonButton(
                              onselect: () {
                                if (_formKey.currentState!.validate()) {
                                  if (getdata?.data?.email != null) {
                                    print({
                                      'otp screen for email':
                                          getdata?.data?.email
                                    });
                                    authProvider
                                        .otpVerifyByEmail(
                                            context: context,
                                            setState: setState,
                                            data: getdata?.data?.email)
                                        .then((value) {
                                      if (value?.status?.httpCode == '200') {
                                        Fluttertoast.showToast(
                                            msg: value?.status?.message ?? '',
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BottomBarScreen()),
                                          (Route<dynamic> route) => false,
                                        );
                                        // Navigator.pop(context);
                                        // Navigator.pop(context);
                                      }
                                    });
                                  } else if (getdata?.data?.mobileNo != null) {
                                    print({
                                      'otp verify with mob':
                                          getdata?.data?.mobileNo
                                    });
                                    authProvider.otpVerify(
                                        context: context,
                                        setState: setState,
                                        data: getdata?.data?.mobileNo);
                                  }
                                }
                              },
                              text: 'SUBMIT')),
                    ],
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset('assets/images/logo_image.png'))
            ],
          ),
        ),
      ),
    );
  }
}
