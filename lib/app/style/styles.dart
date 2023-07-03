import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  // declare two fonts into separate varibales

  // header style
  static TextStyle headerStyles(
      {Color? color, double? size, FontWeight? weight}) {
    return GoogleFonts.roboto(
        color: color ?? Colors.black,
        fontSize: size ?? 15,
        fontWeight: weight ?? FontWeight.bold);
  }

  // extend the header style into body
  static bodyStyle({Color? color, double? size, FontWeight? weight}) {
    return GoogleFonts.roboto(
        color: color ?? Colors.black,
        fontSize: size ?? 13,
        fontWeight: weight ?? FontWeight.normal);
  }

  static bodyStyle2({Color? color, FontWeight? weight}) {
    return GoogleFonts.roboto(
      color: color ?? Colors.black,
      fontSize: 11,
      fontWeight: weight ?? FontWeight.normal,
    );
  }

  static final TextStyle buttonStyles =
      GoogleFonts.montserrat(color: Colors.black, fontSize: 14);
}
