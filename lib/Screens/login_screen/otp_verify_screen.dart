import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:e_basket/common_file/common_button.dart';
import 'package:e_basket/common_file/common_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:e_basket/models/login_model.dart';
import 'package:e_basket/models/user-model.dart';
import 'package:e_basket/utils/sharepreferences_file.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String subtitle;
  final LoginModel? resp;
  final UserModel? editResp;
  const OtpVerifyScreen(
      {super.key, required this.subtitle, this.resp, this.editResp});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthProvider authProvider = AuthProvider();
  LoginModel? getdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata = widget.resp;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // authProvider.otpController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (getdata?.data?.otp != null) {
      authProvider.otpController.text = getdata?.data?.otp ?? '';
    }
    //  AuthProvider authProvider = Provider.of(context, listen: false);

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
                      Center(
                          child: Text(
                        'E-Construction',
                        style: TextConstant().logoText,
                      )),
                      SizedBox(
                        height: 60,
                      ),
                      Center(
                          child: Text(
                        'Otp Verification',
                        style: GoogleFonts.roboto(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant().textColor),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        widget.subtitle,
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
                          blinkWhenObscuring: true,
                          blinkDuration: Duration(seconds: 500),
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
                              activeBoxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 4),
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.3),
                                )
                              ],
                              inActiveBoxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 4),
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.3),
                                )
                              ],
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
                                        print(
                                            "userid..response,,,,....${value?.data?.userId}");
                                        Fluttertoast.showToast(
                                            msg: value?.status?.message ?? '',
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomBarScreen(
                                                      userid:
                                                          value?.data?.userId,
                                                    )));
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
