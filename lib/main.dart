import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      theme:
          ThemeData.light().copyWith(textTheme: GoogleFonts.poppinsTextTheme()),
      home: SafeArea(child: HomeScreen())));
}
