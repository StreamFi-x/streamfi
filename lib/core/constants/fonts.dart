import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StreamfiFonts {
  static TextStyle h1(BuildContext context) => GoogleFonts.inter(
        fontSize: textSize(context, 4),
        height: 1.6,
        fontWeight: FontWeight.w600,
      );

  static TextStyle h2(BuildContext context) => GoogleFonts.inter(
        fontSize: textSize(context, 3),
        height: 1.6,
        fontWeight: FontWeight.w700,
      );

  static TextStyle h3(BuildContext context) => GoogleFonts.inter(
        fontSize: textSize(context, 2.5),
        height: 1.6,
        fontWeight: FontWeight.w400,
      );

  static TextStyle b1(BuildContext context) => GoogleFonts.inter(
        fontSize: textSize(context, 1.5),
        fontWeight: FontWeight.w600,
        height: 1.6,
      );

  static TextStyle b2(BuildContext context) => GoogleFonts.inter(
        fontSize: textSize(context, 1.5),
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle b3(BuildContext context) => GoogleFonts.inter(
        fontSize: textSize(context, 1.2),
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static double textSize(BuildContext context, double size) {
    final vph = MediaQuery.of(context).size.longestSide;
    final vpw = MediaQuery.of(context).size.shortestSide;

    final val = pow(vph, 2) + pow(vpw, 2);

    var hyp = sqrt(val);
    hyp = hyp > 1000 ? 1000 : hyp;

    return size * (hyp / 100);
  }
}
