

import 'dart:ffi';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/home_screen.dart';
import 'package:triptaptoe_app/widgets/app_bar_with_back_arrow.dart';
import 'package:triptaptoe_app/widgets/custom_input_field.dart';

import '../widgets/edit_trip_form.dart';

class EditTripScreen extends StatefulWidget {
  const EditTripScreen({
    super.key,
    required this.trip,
    });

  final TripDTO trip;

  @override
  State<EditTripScreen> createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTripScreen> {

  late String _name ;
  late String _cityOfDeparture;
  late String _cityOfArrival;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _name = widget.trip.name;
    _cityOfDeparture = widget.trip.cityOfDeparture;
    _cityOfArrival = widget.trip.cityOfArrival;
    _startDate = widget.trip.startDate;
    _endDate = widget.trip.endDate;
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBarWithBackArrow(
        screen: HomeScreen()
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO inserire un modo per salvare i dati sul json dell'app
          print("Pressed floating button");
          print("""
          _name: $_name
          _cityOfDeparture: $_cityOfDeparture
          _cityOfArrival: $_cityOfArrival
          _startDate: $_startDate
          _endDate: $_endDate
          """);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogEditTrip();
            }
          );
        }, 
        child: const Icon(Icons.save,color: Colors.white),
        backgroundColor: Color.fromRGBO(53, 16, 79, 1),
        shape: CircleBorder(),

      ),
      body: Padding(
        padding: EdgeInsets.only(left: 29,right: 29),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              const Text(
                "Edit your trip",
                style: TextStyle(
                    color: Color.fromRGBO(45, 45, 45, 1),
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
                
              ),
              EditTripForm(
                trip: widget.trip,
                startDate: _startDate,
                endDate: _endDate,
                onChangeName: (input) {
                  setState(() {
                    _name = input;
                  });
                },
                onChangeCityOfDeparture: (input) {
                  setState(() {
                    _cityOfDeparture = input;
                  });
                },
                onChangeCityOfArrival: (input) {
                  setState(() {
                    _cityOfArrival = input;
                  });
                },
                onChangeDate: (dates) {
                  if (dates.length == 2) {
                    setState(() {
                      _startDate = dates[0]!;
                      _endDate = dates[1]!;
                    });
                  } else {
                    setState(() {
                      _startDate = dates[0]!;
                      _endDate = dates[0]!;
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.abc),label: "Ciao"),
          BottomNavigationBarItem(icon: Icon(Icons.abc),label:  "Ciao"),
        ]
      ),
    );
  }
}

class DialogEditTrip extends StatefulWidget {
  const DialogEditTrip({Key? key});

  @override
  State<DialogEditTrip> createState() => _DialogEditTripState();
}

class _DialogEditTripState extends State<DialogEditTrip> {
  final String contentText =
      "Changing this section will permanently erase all your itinerary information.\nDo you want to proceed?";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Warning!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(contentText,textAlign: TextAlign.center,style: TextStyle(fontSize: 16.0),),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                SizedBox(width: 20.0),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(53, 16, 79, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("Continue"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}