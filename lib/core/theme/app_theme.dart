import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _seed = Color(0xFF3F51B5);

static ThemeData _build(Brightness b) {
  final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: b);
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    fontFamily: GoogleFonts.poppins().fontFamily,
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

  static final light = _build(Brightness.light);
  static final dark = _build(Brightness.dark);
}