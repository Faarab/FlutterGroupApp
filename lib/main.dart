import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:triptaptoe_app/models/DayDTO.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';
import 'screens/trip_details_screen.dart';
import 'widgets/custom_input_field.dart';
import 'widgets/home_screen_bottom_navigation_bar.dart';
import 'widgets/trip_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import 'widgets/trip_details_form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      theme:
          ThemeData.light().copyWith(textTheme: GoogleFonts.poppinsTextTheme()),
      home: SafeArea(child: HomeScreen())));
}
