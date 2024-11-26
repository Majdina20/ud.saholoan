import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

const basicColor = Color(0xff4DD7D7);
const focousedColor = Color(0xffF83758);
const greyColor = Color(0xffD9D9D9);
const cloudlColor = Color(0xfff1faff);
const greenColor = Color(0xff00695B);
const darkColor = Color(0xff011714);
const darkGreenColor = Color(0xff447C2A);
const darkBlueColor = Color(0xff548FE8);
const darkJinggaColor = Color(0xffC39B5E);
const abuButton = Color(0xffC6BDE3);

final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');

final titleText = GoogleFonts.inter(
    textStyle: const TextStyle(
  fontSize: 23,
  fontWeight: FontWeight.bold,
));
final darkTitleText = GoogleFonts.inter(
    textStyle: const TextStyle(
  color: Colors.black,
));

final pinkText = GoogleFonts.montserrat(
    textStyle: const TextStyle(
  color: focousedColor,
));
final basicText = GoogleFonts.inter(
    textStyle: const TextStyle(
  color: darkColor,
));

final buttonText = GoogleFonts.inter(
    textStyle: const TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.w600,
));

final greyText = GoogleFonts.montserrat(
    textStyle: const TextStyle(
  color: greyColor,
));

final whiteText = GoogleFonts.montserrat(
    textStyle: const TextStyle(
  color: Colors.white,
));

class Picker {
  List<Color> pickerColor = [
    const Color(0xffFFFF00),
    const Color(0xffF2DCB3),
    const Color(0xff808080),
    const Color(0xff008000),
    const Color(0xff0000ff),
    const Color(0xffFF0000),
    const Color(0xffFFFFFF),
    const Color(0xff000000),
    const Color(0xffFFA500),
    const Color(0xffe8e1e1),
    const Color(0xff3EB489),
    const Color(0xffA47DAB),
    const Color(0xffA020F0),
    const Color(0xff72b2ed),
    const Color(0xffFF8DA1),
    const Color(0xffA1662F),
    const Color(0xffFFFFe0),
    const Color(0xffe8d4b3),
    const Color(0xff59473f),
    const Color(0xff85461e),
    const Color(0xffffc922),
    const Color(0xff1b1e23),
    const Color(0xff670A0A),
  ];
}
