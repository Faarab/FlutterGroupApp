import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:triptaptoe_app/models/state/itinerary_state.dart';
import 'screens/home_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => ItineraryState(),
    child: MaterialApp(
        theme:
            ThemeData.light().copyWith(textTheme: GoogleFonts.poppinsTextTheme()),
        home: SafeArea(child: HomeScreen())),
  ));
}
