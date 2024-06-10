import 'package:e_basket/Providers/AuthProvider.dart';
import 'package:e_basket/Screens/login_screen/login_screen.dart';
import 'package:e_basket/Screens/register_screen/register_screen.dart';
import 'package:e_basket/common_file/common_button.dart';
import 'package:e_basket/common_file/common_screen.dart';
import 'package:e_basket/constant_file/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
   final _formKey = GlobalKey<FormState>();
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
              // CommonScreen(),
              Center(
                child: SizedBox(
                  width: size.width * 0.7,
                  child: Form(
                    key:_formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          'Enter your email id',
                          style: TextConstant().lableText,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: TextFormField(
                            controller: authProvider.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: 'Email Id',
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
                          height: 20,
                        ),
                        Center(
                            child: CommonButton(
                                onselect: () {
                                  if (_formKey.currentState!
                                      .validate()) {
                                    authProvider.loginByEmail(
                                        context: context, setState: setState);
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
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text(
                                'Login with Phone Number',
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
                                            builder: (context) =>
                                               const RegisterScreen()));
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