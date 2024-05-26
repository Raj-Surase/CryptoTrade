import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themes() {
  return ThemeData(
    textTheme: TextTheme(
      labelMedium: GoogleFonts.getFont(
        'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: GoogleFonts.getFont(
        'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[100],
      elevation: 0,
      // toolbarHeight: 100,
      titleTextStyle: GoogleFonts.getFont(
        'Coiny',
        fontSize: 40,
        fontWeight: FontWeight.w400,
        color: Colors.amber[600],
      ),
    ),
    scaffoldBackgroundColor: Colors.grey[100],
  );
}
// }
