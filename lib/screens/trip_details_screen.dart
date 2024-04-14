import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/main.dart';
import 'package:triptaptoe_app/screens/home_screen.dart';
import 'package:triptaptoe_app/widgets/app_bar_with_back_arrow.dart';

import '../widgets/trip_details_form.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});
  

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  List<DateTime?>? _tripDates = [];
  var _name;
  var _cityOfDeparture;
  var _cityOfArrival;
  var _startDate;
  var _endDate;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBarWithBackArrow(),
      body: Padding(
        padding: EdgeInsets.only(left: 29, right: 29),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                "Create a new trip",
                style: TextStyle(
                    color: Color.fromRGBO(45, 45, 45, 1),
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              TripDetailsForm(),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
