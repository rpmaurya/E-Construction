import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_basket/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:e_basket/Screens/login_screen/login_screen.dart';
import 'package:e_basket/common_file/common_button.dart';
import 'package:e_basket/constant_file/home_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.93,
            child: Column(children: [
              Expanded(
                child: Container(
                  // margin: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(15),
                  ),
                  child: CarouselSlider.builder(
                    itemCount: HomeConstants.crouselitems.length,
                    itemBuilder:
                        (BuildContext context, index, int pageViewIndex) =>
                            InkWell(
                      onTap: (() {}),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // margin: EdgeInsets.symmetric(
                        //     vertical: 5, horizontal: 5),
                        child: ClipRRect(
                            // borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                          HomeConstants.crouselitems[index]['crouselImage'],
                          fit: BoxFit.fill,
                        )),
                      ),
                    ),
                    carouselController: _controller,
                    options: CarouselOptions(
                        viewportFraction: 1.0,
                        height: MediaQuery.of(context).size.height,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 4.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    HomeConstants.crouselitems.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          shape: BoxShape.circle,
                          color: Colors.white
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)
                          // color: Get.isDarkMode
                          //     ? Colors.white
                          //     : Colors.black.withOpacity(
                          //         _current == entry.key ? 0.9 : 0.4)
                          ),
                    ),
                  );
                }).toList(),
              ),
            ]),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: ()async{
                      SharedPreferences pref = await SharedPreferences.getInstance();

                pref.getString('token') != null
                    ? Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomBarScreen()))
                    : Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
            }, child: Text('SKIP>>'))),
          // CommonButton(
          //     text: 'SKIP',
          //     onselect: () async {
          //       SharedPreferences pref = await SharedPreferences.getInstance();

          //       pref.getString('token') != null
          //           ? Navigator.pushReplacement(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => const BottomBarScreen()))
          //           : Navigator.pushReplacement(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => const LoginScreen()));
          //     })
        ],
      ),
    );
  }
}
