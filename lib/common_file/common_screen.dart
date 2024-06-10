import 'package:flutter/material.dart';

class CommonScreen extends StatelessWidget {
  const CommonScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        body: Container(
      // height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromRGBO(226, 249, 230, 1),
            Color.fromRGBO(255, 255, 255, 1)
          ])),
      child: SafeArea(
        child: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Image.asset(
                  'assets/images/image1.png',
                  scale: 1.1,
                ),
              ),
              Positioned(
                left: 0,
                top: 40,
                child: Image.asset(
                  'assets/images/image2.png',
                  scale: 1.1,
                ),
              ),
              Positioned(
                // top: 180,
                right: 0,
                bottom: 80,
                child: Image.asset(
                  'assets/images/image3.png',
                  scale: 1.2,
                  // fit: BoxFit.fill,
                ),
              ),
              Positioned(
                // top: 100,
                left: 0,
                bottom: 0,
                child: Image.asset(
                  'assets/images/image4.png',
                  scale: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}