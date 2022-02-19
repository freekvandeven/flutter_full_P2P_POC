import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme({bool helper = false}) {
  return ThemeData(
    checkboxTheme: CheckboxThemeData(
      fillColor:
          MaterialStateProperty.all(Color(0xFFFF8691)),
    ),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: Color(0xFF1C3B64),
          secondary: Color(0xFFFF8691),
        ),
    splashColor: Color(0xFFFF7884),
    backgroundColor: Color(0xFFe8e9eb),
    primaryColor: Color(0xFF0078bd),
    cardColor: Color(0xFFE8EAEC),
    textTheme: TextTheme(
      button: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      headline1: GoogleFonts.montserrat(
        color: Color(0xFF0078bd),
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
      headline2: GoogleFonts.montserrat(
        color: Color(0xFF424e5a),
        fontSize: 25,
        fontWeight: FontWeight.w700,
      ),
      headline3: GoogleFonts.montserrat(
        color: Color(0xFF424e5a),
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      headline4: GoogleFonts.montserrat(
        color: Color(0xFF424e5a),
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyText1: GoogleFonts.montserrat(
        color: Color(0xFF424e5a),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: GoogleFonts.montserrat(
        color: Color(0xFF424e5a),
        fontSize: 16,
        fontWeight: FontWeight.w200,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isCollapsed: true,
      isDense: true,
      border: InputBorder.none,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xFFFF7884),
    ),
  );
}
