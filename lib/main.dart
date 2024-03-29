import 'dart:convert';
import 'dart:ui';
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
  List<DateTime?>? _tripDates = [];
  var _name;
  var _cityOfDeparture;
  var _cityOfArrival;
  var _startDate;
  var _endDate;

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
              const SizedBox(height: 16),
              if (_tripDates!.length == 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Departure",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(45, 45, 45, 1),
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          "${_tripDates![0]!.day.toString().padLeft(2, '0')}/${_tripDates![0]!.month.toString().padLeft(2, '0')}/${_tripDates![0]!.year}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Return",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(45, 45, 45, 1),
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          "${_tripDates![1]!.day.toString().padLeft(2, '0')}/${_tripDates![1]!.month.toString().padLeft(2, '0')}/${_tripDates![1]!.year}",
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    )
                  ],
                ),
              if (_tripDates!.length == 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Departure",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(45, 45, 45, 1),
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          "${_tripDates![0]!.day.toString().padLeft(2, '0')}/${_tripDates![0]!.month.toString().padLeft(2, '0')}/${_tripDates![0]!.year}",
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Return",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(45, 45, 45, 1),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${_tripDates![0]!.day.toString().padLeft(2, '0')}/${_tripDates![0]!.month.toString().padLeft(2, '0')}/${_tripDates![0]!.year}",
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    )
                  ],
                ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: OutlinedButton.icon(
                    onPressed: () async {
                      var results = await showCalendarDatePicker2Dialog(
                        context: context,
                        config: CalendarDatePicker2WithActionButtonsConfig(
                          calendarType: CalendarDatePicker2Type.range,
                          firstDate: DateTime.now(),
                          controlsTextStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromRGBO(53, 16, 79, 1)),
                        ),
                        dialogSize: const Size(325, 400),
                        value: [],
                        borderRadius: BorderRadius.circular(16),
                      );
                      //If results (dates selected) is not empty, you set startDate and endDate according to the length of the trip
                      //If the trip is 1 day long, startDate = endDate, otherwise they're set to the corresponding values
                      if (results != null) {
                        setState(() {
                          _tripDates = results;
                        });
                        if (results.length == 2) {
                          setState(() {
                            _startDate = results[0];
                            _endDate = results[1];
                          });
                        } else if (results.length == 1) {
                          setState(() {
                            _startDate = results[0];
                            _endDate = results[0];
                          });
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Color.fromRGBO(53, 16, 79, 1),
                    ),
                    label: Text(_tripDates!.isEmpty
                        ? "Select trip dates"
                        : "Change trip dates"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      side: const BorderSide(
                          color: Color.fromRGBO(53, 16, 79, 1), width: 2),
                      foregroundColor: const Color.fromRGBO(53, 16, 79, 1),
                    )),
              ),
              TripDetailsForm(
                getUserInput: (userInput) {
                  var fieldId = userInput['fieldId'];
                  var newValue = userInput['newValue'];
                  switch (fieldId) {
                    case 1:
                      setState(() {
                        _name = newValue;
                        print("Name " + _name);
                      });
                      break;
                    case 2:
                      setState(() {
                        _cityOfDeparture = newValue;
                        print("Departure " + _cityOfDeparture);
                      });
                      break;
                    case 3:
                      setState(() {
                        _cityOfArrival = newValue;
                        print("Arrival " + _cityOfArrival);
                      });
                      break;
                  }
                },
              )
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
      required this.onChanged,
      this.fieldId,
      this.getUserInput});

  final int? fieldId;
  final String fieldLabel;
  final String fieldHintText;
  final void Function(String) onChanged;
  final void Function(Map<String, dynamic>)? getUserInput;

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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field cannot be empty';
              }
              if (value.startsWith(" ")) {
                return 'Value cannot contain blank spaces';
              }
              return null;
            },
            onChanged: (value) {
              onChanged(value);
              getUserInput?.call({"fieldId": fieldId, "newValue": value});
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: fieldHintText,
            ))
      ],
    );
  }
}

class TripDetailsForm extends StatefulWidget {
  const TripDetailsForm({super.key, this.getUserInput});

  final void Function(Map<String, dynamic>)? getUserInput;

  @override
  State<TripDetailsForm> createState() => _TripDetailsFormState();
}

class _TripDetailsFormState extends State<TripDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputField(
            fieldId: 1,
            fieldLabel: "Title",
            fieldHintText: "e.g. My Trip",
            onChanged: (value) {
              (value);
            },
            getUserInput: widget.getUserInput,
          ),
          CustomInputField(
            fieldId: 2,
            fieldLabel: "Where from?",
            fieldHintText: "e.g. Bologna",
            onChanged: (value) {
              (value);
            },
            getUserInput: widget.getUserInput,
          ),
          CustomInputField(
            fieldId: 3,
            fieldLabel: "Where to?",
            fieldHintText: "e.g. Madrid",
            onChanged: (value) {
              (value);
            },
            getUserInput: widget.getUserInput,
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
