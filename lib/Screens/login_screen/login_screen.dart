import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Screens/login_screen/email_login_screen.dart';
import 'package:e_basket/Screens/register_screen/register_screen.dart';
import 'package:e_basket/common_file/common_button.dart';
import 'package:e_basket/common_file/common_screen.dart';
import 'package:e_basket/constant_file/color_constant.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final  formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context, listen: false);
  
   var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // const CommonScreen(),
              Center(
                child: SizedBox(
                  width: size.width * 0.7,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text('E-Construction',style:TextConstant().logoText,)),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                            child: Text(
                          'Login',
                          style:TextConstant().loginText,
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Enter your phone number',
                          style: TextConstant().lableText,
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        
                        // PhoneFormField(
                        //     decoration: InputDecoration(
                        //       // counterText: '',
                        //       filled: true,
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10),
                        //           borderSide: BorderSide(
                        //               color: Color.fromRGBO(0, 0, 0, 0.5))),
                        //       fillColor: Colors.white,
                        //       contentPadding: EdgeInsets.symmetric(
                        //           vertical: 10, horizontal: 10),
                        //     ),
                        //     initialValue: PhoneNumber.parse('+91'),
                        //     validator: PhoneValidator.compose([
                        //       PhoneValidator.required(context,
                        //           errorText: 'Enter the valid number'),
                        //       PhoneValidator.validMobile(context),
                        //     ]),
                        //     onChanged: (phoneNumber) => {
                        //           setState(() {
                        //             controller.number = phoneNumber.nsn;
                        //           }),
                        //           // print({'phone number.....': phoneNumber.nsn})
                        //         }),
                        Container(
                          // height: 45,
                          width: size.width,
                          child: IntlPhoneField(
                            controller: authProvider.phoneController,
                            flagsButtonPadding: EdgeInsets.all(5.0),
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
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(0, 0, 0, 0.5))),
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'kj,n,n,k';
                              }
                            
                            },
                          ),
                        ),
                        // Text('You will receive a 4 digit code for verification'),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: CommonButton(
                                onselect: () {
                               
                                  if (formKey.currentState!
                                      .validate()) {
                                  

                                    authProvider.loginByMobile(
                                      context: context,
                                      setState: setState,
                                    );

                                    // controller.login();
                                    
                                  }
                                },
                                text: 'GET OTP')),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Text(
                          '---------- or ----------',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold),
                        )),
                        Center(
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EmailLoginScreen()));
                              },
                              child: Text(
                                'Login with Email',
                                style:TextConstant().textStyle,
                              )),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an Account ?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>const RegisterScreen()));
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextConstant().textStyle,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
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