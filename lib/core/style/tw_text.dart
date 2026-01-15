import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tw_colors.dart';

class TWText {
  // Text sizes (like Tailwind text-*)
  static TextStyle xs(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    final colors = TWColors.of(context);
    return GoogleFonts.inter(
      fontSize: 12,
      color: color ?? colors.textSecondary,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
  
  static TextStyle sm(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    final colors = TWColors.of(context);
    return GoogleFonts.inter(
      fontSize: 14,
      color: color ?? colors.textSecondary,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
  
  static TextStyle base(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    final colors = TWColors.of(context);
    return GoogleFonts.inter(
      fontSize: 16,
      color: color ?? colors.textPrimary,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
  
  static TextStyle lg(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    final colors = TWColors.of(context);
    return GoogleFonts.inter(
      fontSize: 18,
      color: color ?? colors.textPrimary,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
  
  static TextStyle xl(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    final colors = TWColors.of(context);
    return GoogleFonts.inter(
      fontSize: 20,
      color: color ?? colors.textPrimary,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
  
  static TextStyle xl2(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    final colors = TWColors.of(context);
    return GoogleFonts.inter(
      fontSize: 24,
      color: color ?? colors.textPrimary,
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }
  
  static TextStyle xl3(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    final colors = TWColors.of(context);
    return GoogleFonts.inter(
      fontSize: 30,
      color: color ?? colors.textPrimary,
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }
  
  static TextStyle xl4(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    final colors = TWColors.of(context);
    return GoogleFonts.inter(
      fontSize: 36,
      color: color ?? colors.textPrimary,
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }
}
