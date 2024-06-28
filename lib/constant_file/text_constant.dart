import 'package:e_basket/constant_file/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextConstant {
  var logoText = GoogleFonts.uncialAntiqua(
    textStyle: TextStyle(fontSize: 24),
    fontWeight: FontWeight.w400,
    color: Color(0xFF894910),
  );
  var textStyle = GoogleFonts.inter(
      color: ColorConstant().textColor,
      fontSize: 16,
      fontWeight: FontWeight.w700);
  var lableText = GoogleFonts.inter(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
  var cardTitle = GoogleFonts.inter(
      textStyle: const TextStyle(fontSize: 18),
      fontWeight: FontWeight.w500,
      color: Colors.black);
  var loginText = GoogleFonts.inter(
      color: Colors.orange[800], fontSize: 24, fontWeight: FontWeight.w700);
  var titleText = GoogleFonts.inter(
      textStyle: const TextStyle(fontSize: 16),
      fontWeight: FontWeight.w700,
      color: const Color.fromRGBO(0, 0, 0, 1));
  var subtitleText = GoogleFonts.inter(
      textStyle: const TextStyle(fontSize: 13),
      fontWeight: FontWeight.w500,
      color: Colors.black);
  var filterText = GoogleFonts.inter(
      height: 2,
      textStyle: const TextStyle(fontSize: 15),
      fontWeight: FontWeight.w400,
      color: const Color.fromRGBO(0, 0, 0, 0.8));
  var cardtitleText = GoogleFonts.roboto(
      textStyle: const TextStyle(fontSize: 16),
      fontWeight: FontWeight.w500,
      color: const Color.fromRGBO(0, 0, 0, 1));
  var buttonText = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);
  var containertext = GoogleFonts.roboto(textStyle: TextStyle(fontSize: 13));
  var flotingTitle = GoogleFonts.inter(
      fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white);
  var flotingSubtitle = GoogleFonts.inter(
      fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white);
  var icontext = GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF894910));
  var drawerText = GoogleFonts.roboto(
      textStyle: const TextStyle(fontSize: 15),
      fontWeight: FontWeight.w500,
      color: const Color.fromRGBO(0, 0, 0, 1));
  var drawersubtitle = GoogleFonts.inter(
      textStyle: const TextStyle(fontSize: 13),
      fontWeight: FontWeight.w500,
      color: Colors.black);
}
