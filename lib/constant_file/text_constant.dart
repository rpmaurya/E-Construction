import 'package:e_basket/constant_file/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextConstant {
   var logoText = GoogleFonts.uncialAntiqua(
      textStyle: TextStyle(fontSize: 24),
      fontWeight: FontWeight.w400,
     
      color: Color(0xFF894910),);
      var textStyle= GoogleFonts.inter(
        color: ColorConstant().textColor,
        fontSize: 16,
        fontWeight: FontWeight.w700
      );
      var lableText=GoogleFonts.inter(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w500);
      var loginText= GoogleFonts.inter(
                              color: Colors.orange[800],
                              
                              fontSize: 24,
                              fontWeight: FontWeight.w700);
  var titleText = GoogleFonts.inter(
      textStyle: TextStyle(fontSize: 16),
      fontWeight: FontWeight.w700,
      color: Color.fromRGBO(0, 0, 0, 1));
  var subtitleText = GoogleFonts.inter(
      textStyle: TextStyle(fontSize: 13),
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(0, 0, 0, 0.8));
       var filterText = GoogleFonts.inter(
        height: 2,
      textStyle: TextStyle(fontSize: 15),
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(0, 0, 0, 0.8));
       var cardtitleText = GoogleFonts.inter(
      textStyle: TextStyle(fontSize: 16),
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(0, 0, 0, 1));
      var buttonText = GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white);
}
