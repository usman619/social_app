import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle titleTextTheme = TextStyle(
  fontFamily: GoogleFonts.firaCode().fontFamily,
  fontWeight: FontWeight.bold,
  letterSpacing: 5,
  fontSize: 18,
);

TextStyle drawerTextTheme = TextStyle(
  fontFamily: GoogleFonts.firaCode().fontFamily,
  fontWeight: FontWeight.normal,
  letterSpacing: 1,
  fontSize: 16,
);

TextStyle bodyTextTheme = TextStyle(
  fontFamily: GoogleFonts.firaCode().fontFamily,
  fontWeight: FontWeight.normal,
  letterSpacing: 1,
  fontSize: 16,
);

TextStyle loginTextTheme(BuildContext context) => TextStyle(
      fontFamily: GoogleFonts.firaCode().fontFamily,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
      fontSize: 24,
      color: Theme.of(context).colorScheme.primary,
    );
