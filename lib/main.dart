import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triptaptoe_app/screens/splash_screen.dart';

import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData.light().copyWith(textTheme: GoogleFonts.poppinsTextTheme()),
      home: SafeArea(child: HomeScreen())));
}
