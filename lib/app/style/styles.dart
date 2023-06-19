import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_ukm/app/style/utils.dart';

class Styles {
  // declare two fonts into separate varibales

  // header style
  static final TextStyle headerStyles = GoogleFonts.inter(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);

  // extend the header style into body
  static final bodyStyle =
      GoogleFonts.montserrat(color: Colors.black, fontSize: 14);

  static final bodyStyle2 =
      GoogleFonts.montserrat(color: Colors.black, fontSize: 11);

  static final TextStyle buttonStyles =
      GoogleFonts.montserrat(color: Colors.black, fontSize: 14);
}
