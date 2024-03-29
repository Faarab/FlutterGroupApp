import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home_screen.dart';
import 'widgets/home_screen_bottom_navigation_bar.dart';
import 'widgets/trip_card.dart';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';

final tripJSON = """{
    "id": "123456",
    "name": "Sample Trip",
    "startDate": "2024-03-25T00:00:00.000Z",
    "endDate": "2024-04-02T00:00:00.000Z",
    "cityOfDeparture": "City A",
    "cityOfArrival": "City B",
    "days": [
      {
        "date": "2024-03-25T00:00:00.000Z",
        "activities": [
          {
            "name": "Activity 1",
            "startTime": "2024-03-25T08:00:00.000Z",
            "openingTime": "2024-03-25T07:00:00.000Z",
            "closingTime": "2024-03-25T17:00:00.000Z",
            "location": "Location 1",
            "price": 10.5
          },
          {
            "name": "Activity 2",
            "startTime": "2024-03-25T10:00:00.000Z",
            "openingTime": "2024-03-25T09:00:00.000Z",
            "closingTime": "2024-03-25T18:00:00.000Z",
            "location": "Location 2",
            "price": 15.75
          }
        ]
      },
      {
        "date": "2024-03-26T00:00:00.000Z",
        "activities": [
          {
            "name": "Activity 3",
            "startTime": "2024-03-26T09:00:00.000Z",
            "openingTime": "2024-03-26T08:00:00.000Z",
            "closingTime": "2024-03-26T16:00:00.000Z",
            "location": "Location 3",
            "price": 20.0
          }
        ]
      }
    ]
  }""";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      theme:
          ThemeData.light().copyWith(textTheme: GoogleFonts.poppinsTextTheme()),
      home: SafeArea(child: TripDetailsScreen())));
}

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  var _name;
  var _cityOfDeparture;
  var _cityOfArrival;
  List<DateTime?>? _tripDates = [];
  var results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(53, 16, 79, 1),
        toolbarHeight: 64,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 29, right: 29),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Create a new trip",
                style: TextStyle(
                    color: Color.fromRGBO(45, 45, 45, 1),
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              CustomInputField(
                  fieldLabel: "Title",
                  fieldHintText: "e.g. My Trip",
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  }),
              CustomInputField(
                  fieldLabel: "Where from?",
                  fieldHintText: "e.g. Bologna",
                  onChanged: (value) {
                    setState(() {
                      _cityOfDeparture = value;
                    });
                  }),
              CustomInputField(
                  fieldLabel: "Where to?",
                  fieldHintText: "e.g. Madrid",
                  onChanged: (value) {
                    setState(() {
                      _cityOfArrival = value;
                    });
                  }),
              ElevatedButton.icon(
                  onPressed: () async {
                    var results = await showCalendarDatePicker2Dialog(
                      context: context,
                      config: CalendarDatePicker2WithActionButtonsConfig(
                        calendarType: CalendarDatePicker2Type.range,
                        firstDate: DateTime.now(),
                      ),
                      dialogSize: const Size(325, 400),
                      value: [],
                      borderRadius: BorderRadius.circular(16),
                    );
                    setState(() {
                      _tripDates = results;
                      print(_tripDates);
                    });
                  },
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: Color.fromRGBO(53, 16, 79, 1),
                  ),
                  label: Text("Select dates"))

              // CalendarDatePicker2(
              //     config: CalendarDatePicker2Config(
              //         calendarType: CalendarDatePicker2Type.range,
              //         firstDate: DateTime.now()),
              //     value: [],
              //     onValueChanged: (dates) {
              //       _tripDates = dates;
              //       print(_tripDates);
              //     })
              // Text(
              //   "Departure date",
              //   style: TextStyle(
              //       fontSize: 16,
              //       color: Color.fromRGBO(45, 45, 45, 1),
              //       fontWeight: FontWeight.bold),
              // ),
              // SizedBox(height: 8),
              // InputDatePickerFormField(
              //     fieldLabelText: "Enter Date",
              //     fieldHintText: "MM/DD/YYYY",
              //     acceptEmptyDate: false,
              //     firstDate: DateTime.now(),
              //     lastDate: DateTime.now())
            ],
          ),
        ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {super.key,
      required this.fieldLabel,
      required this.fieldHintText,
      required this.onChanged});

  final String fieldLabel;
  final String fieldHintText;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(fieldLabel,
            style: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(45, 45, 45, 1),
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
            onChanged: (value) {
              onChanged(value);
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: fieldHintText,
            ))
      ],
    );
  }
}
