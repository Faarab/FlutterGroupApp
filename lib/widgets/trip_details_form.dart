import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/main.dart';
import 'package:triptaptoe_app/models/DayDTO.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/home_screen.dart';
import 'package:triptaptoe_app/services/getDaysList.dart';
import 'package:triptaptoe_app/widgets/custom_input_field.dart';

class TripDetailsForm extends StatefulWidget {
  const TripDetailsForm({
    super.key,
  });

  @override
  State<TripDetailsForm> createState() => _TripDetailsFormState();
}

class _TripDetailsFormState extends State<TripDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  List<DateTime?>? _tripDates = [];
  var _name;
  var _cityOfDeparture;
  var _cityOfArrival;
  var _startDate;
  var _endDate;

  Future<void> addTripToJson(TripDTO newTrip) async {
    final String response =
        await rootBundle.loadString('assets/images/sample.json');
    final Map<String, dynamic> data = json.decode(response);
    List<dynamic> dynamicTripsList = data["trips"];
    //Copy the existing list and convert it to a list of TripDTOs, so that I can later add a new TripDTO item
    var tripsList = dynamicTripsList.map(
      (e) {
        return TripDTO.fromJson(e);
      },
    ).toList();
    print(tripsList);
    //Add the new trip to the original list
    tripsList.add(newTrip);
    print("------------");
    print(tripsList);
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    final randomString = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return randomString;
  }

  Future<void> readAndWriteJson() async {
    // final contenutoJSON = json.decode(fileContent);
    // contenutoJSON['trips'][0] = {"exampleKey": "exampleValue"};
    // print(contenutoJSON);

    //Access the "trips.json" file
    final myDirectory = await getApplicationDocumentsDirectory();
    final myPath = myDirectory.path;
    final myFile = File('$myPath/trips.json');

    //Read the file contents, if the file is empty initialize it otherwise add a new trip
    final contents = await myFile.readAsString();
    if (contents == "") {
      final _id = getRandomString(5);
      final newTrip = new TripDTO(
          id: _id,
          name: _name,
          startDate: _startDate,
          endDate: _endDate,
          cityOfDeparture: _cityOfDeparture,
          cityOfArrival: _cityOfArrival,
          days: getDaysList(_startDate, _endDate));
      final fileStructure = {
        "trips": [newTrip]
      };
      print("fileStructure" + fileStructure.toString());
      myFile.writeAsString(jsonEncode(fileStructure));
      // myFile.writeAsString("""{
      //   "trips": [$newTrip]
      // }""");
    } else {
      final contentsJSON = jsonDecode(contents);
      final tripsList = contentsJSON['trips'];
      final _id = getRandomString(5);
      final newTrip = new TripDTO(
          id: _id,
          name: _name,
          startDate: _startDate,
          endDate: _endDate,
          cityOfDeparture: _cityOfDeparture,
          cityOfArrival: _cityOfArrival,
          days: getDaysList(_startDate, _endDate));
      final newTripsList = [...tripsList, newTrip];
      print("newTripsList$newTripsList");
      contentsJSON['trips'] = newTripsList;
      myFile.writeAsString(jsonEncode(contentsJSON));
    }
  }

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
            onChanged: (userInput) {
              print(userInput);
              setState(() {
                _name = userInput;
              });
            },
          ),
          CustomInputField(
            fieldId: 2,
            fieldLabel: "Where from?",
            fieldHintText: "e.g. Bologna",
            onChanged: (userInput) {
              print(userInput);
              setState(() {
                _cityOfDeparture = userInput;
              });
            },
          ),
          CustomInputField(
            fieldId: 3,
            fieldLabel: "Where to?",
            fieldHintText: "e.g. Madrid",
            onChanged: (userInput) {
              print("onChanged" + userInput);
              setState(() {
                _cityOfArrival = userInput;
              });
            },
          ),
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
          const SizedBox(height: 16),
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

                  print(results);
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
          if (_tripDates!.isEmpty)
            const SizedBox(
              height: 100,
            ),
          if (_tripDates!.isNotEmpty)
            const SizedBox(
              height: 46,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                    textStyle: MaterialStatePropertyAll(
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    padding: MaterialStatePropertyAll(EdgeInsets.only(
                        top: 16, bottom: 16, left: 32, right: 32)),
                    backgroundColor:
                        MaterialStatePropertyAll(Color.fromRGBO(53, 16, 79, 1)),
                    foregroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(255, 255, 255, 1))),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    if (_tripDates!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Trip dates must be selected')),
                      );
                    } else {
                      print(
                          "Name: $_name + Depart: $_cityOfDeparture + Arrival: $_cityOfArrival + Start: $_startDate + End: $_endDate");
                      var _newTrip = new TripDTO(
                          id: "1",
                          name: _name,
                          startDate: _startDate,
                          endDate: _endDate,
                          cityOfDeparture: _cityOfDeparture,
                          cityOfArrival: _cityOfArrival,
                          days: getDaysList(_startDate, _endDate)); //TODO
                      //addTripToJson(_newTrip);
                      readAndWriteJson();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                              child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Your trip was created!",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(45, 45, 45, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                          textAlign: TextAlign.center,
                                          "You can edit your itinerary now, or get back to it later.",
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(45, 45, 45, 1),
                                              fontSize: 16)),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                                onPressed: () => {
                                                      Navigator.of(context)
                                                          .popUntil((route) =>
                                                              route.isFirst),
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  HomeScreen()))
                                                    },
                                                child: Text("Back to home"),
                                                style: OutlinedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          53, 16, 79, 1),
                                                      width: 2),
                                                  foregroundColor:
                                                      const Color.fromRGBO(
                                                          53, 16, 79, 1),
                                                )),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  backgroundColor:
                                                      Color.fromRGBO(
                                                          53, 16, 79, 1),
                                                  foregroundColor:
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                ),
                                                onPressed: () {},
                                                child: Text("Edit trip")),
                                          )
                                        ],
                                      )
                                    ],
                                  ))));
                    }
                  }
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
