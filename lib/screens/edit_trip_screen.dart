

import 'dart:ffi';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/home_screen.dart';
import 'package:triptaptoe_app/services/navigation.dart';
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

  late String _name;
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
          if( _cityOfDeparture == widget.trip.cityOfDeparture 
              && _cityOfArrival == widget.trip.cityOfArrival 
              && _startDate == widget.trip.startDate 
              && _endDate == widget.trip.endDate){ 
            //TODO meto di salvataggio dati su json
            //TODO inserire uno spinner di caricamento mentre salva i dati
            navigateToHomeWithSlideTransition(context);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const DialogEditTrip();
              }
            );
          }
        },
        backgroundColor: const Color.fromRGBO(53, 16, 79, 1),
        shape: const CircleBorder(), 
        child: const Icon(Icons.save,color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: 1, // Numero di elementi nella lista (in questo caso, solo uno)
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 29, right: 29),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: [
                const SizedBox(height: 32,),
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
                      if(input.length > 0) {
                        _name = input;
                      } else {
                        _name = widget.trip.name;
                      }
                    });
                  },
                  onChangeCityOfDeparture: (input) {
                    setState(() {
                      if(input.length > 0) {
                        _cityOfDeparture = input;
                      } else {
                        _cityOfDeparture = widget.trip.cityOfDeparture;
                      }
                    });
                  },
                  onChangeCityOfArrival: (input) {
                    setState(() {
                      if(input.length > 0) {
                        _cityOfArrival = input;
                      } else {
                        _cityOfArrival = widget.trip.cityOfArrival;
                      }
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
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
    return AlertDialog.adaptive(
      insetAnimationDuration: const Duration(milliseconds: 100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child : TextButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: Color.fromRGBO(53, 16, 79, 1))),
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
                  child: const Text("Cancel",style: TextStyle(color: Color.fromRGBO(53, 16, 79, 1),fontWeight: FontWeight.bold,fontSize: 18)),
                ),
              ),
              const SizedBox(width: 20.0),
              SizedBox(
                width: 120,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(53, 16, 79, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )
                  ),
                  onPressed: () {
                    //TODO inserire la funzione per salvare i dati e lo spinning
                    navigateToHomeWithSlideTransition(context);
                  },
                  child: const Text("Continue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ),
            ],
          ),
      ],
      content: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Warning!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(contentText,textAlign: TextAlign.center,style: const TextStyle(fontSize: 20.0),),
          ],
        ),
      ),
    );
  }
}