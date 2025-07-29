import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  return ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(textTheme).copyWith(
      displayLarge: GoogleFonts.poppins(textStyle: textTheme.displayLarge, fontWeight: FontWeight.w700),
      displayMedium: GoogleFonts.poppins(textStyle: textTheme.displayMedium, fontWeight: FontWeight.w700),
      displaySmall: GoogleFonts.poppins(textStyle: textTheme.displaySmall, fontWeight: FontWeight.w700),
      headlineLarge: GoogleFonts.poppins(textStyle: textTheme.headlineLarge, fontWeight: FontWeight.w600),
      headlineMedium: GoogleFonts.poppins(textStyle: textTheme.headlineMedium, fontWeight: FontWeight.w600),
      headlineSmall: GoogleFonts.poppins(textStyle: textTheme.headlineSmall, fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.poppins(textStyle: textTheme.titleLarge, fontWeight: FontWeight.w400),
      titleMedium: GoogleFonts.poppins(textStyle: textTheme.titleMedium, fontWeight: FontWeight.w400),
      titleSmall: GoogleFonts.poppins(textStyle: textTheme.titleSmall, fontWeight: FontWeight.w400),
      bodyLarge: GoogleFonts.poppins(textStyle: textTheme.bodyLarge, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium, fontWeight: FontWeight.w500),
      bodySmall: GoogleFonts.poppins(textStyle: textTheme.bodySmall, fontWeight: FontWeight.w500),
      labelLarge: GoogleFonts.poppins(textStyle: textTheme.labelLarge, fontWeight: FontWeight.w400),
      labelMedium: GoogleFonts.poppins(textStyle: textTheme.labelMedium, fontWeight: FontWeight.w400),
      labelSmall: GoogleFonts.poppins(textStyle: textTheme.labelSmall, fontWeight: FontWeight.w400),
    ),
  );
}
