import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:e_basket/Screens/login_screen/login_screen.dart';
import 'package:e_basket/Screens/starting_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onBoarding();
  }
   onBoarding() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

 await Future.delayed(Duration(seconds: 2),()=>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()))
 
 );
    // SharepreferencClass getuser = SharepreferencClass();
    // print({'getuser.....': getuser.getUser()});

    // await Future.delayed(
    //     const Duration(seconds: 2),
    //     () => pref.getString('token') != null
    //         ? Navigator.pushReplacement(context,
    //             MaterialPageRoute(builder: (context) => const BottomBarScreen()))
    //         : Navigator.pushReplacement(context,
    //             MaterialPageRoute(builder: (context) => const LoginScreen())));
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        backgroundColor: Colors.transparent,
        // body: Container(
        //   decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //           begin: Alignment.center,
        //           end: Alignment.bottomCenter,
        //           colors: [
        //         Color.fromRGBO(226, 249, 230, 1),
        //         Color.fromRGBO(255, 255, 255, 1)
        //       ])),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     // crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Image.asset(
        //         'assets/images/splash_logo.png',
        //         // width: 253,
        //         // height: 91,
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       Image.asset(
        //         'assets/images/splash_bottom_logo.png',
        //         // height: 435,
        //         // width: 426,
        //       ),
        //     ],
        //   ),
        // )
       body: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height ,
        child: Image.asset('assets/images/onboarding.png',fit: BoxFit.fill,)),
        );
  }
}