//TODO sistemare bug spinning quando salvo le modifiche dal dialogue essro rimane aperto e non visualizzo lo spinning dietro

import 'dart:ffi';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/home_screen.dart';
import 'package:triptaptoe_app/services/navigation.dart';
import 'package:triptaptoe_app/widgets/app_bar_with_back_arrow.dart';
import 'package:triptaptoe_app/widgets/custom_input_field.dart';
import 'package:triptaptoe_app/widgets/edit_trip_body.dart';

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
  bool isSaving = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _name = widget.trip.name;
    _cityOfDeparture = widget.trip.cityOfDeparture;
    _cityOfArrival = widget.trip.cityOfArrival;
    _startDate = widget.trip.startDate;
    _endDate = widget.trip.endDate;
  }

  void onItemSelected (int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackArrow(
        screen: HomeScreen()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if( _cityOfDeparture == widget.trip.cityOfDeparture 
              && _cityOfArrival == widget.trip.cityOfArrival 
              && _startDate == widget.trip.startDate 
              && _endDate == widget.trip.endDate){ 
            setState(() {
              print("sono qui");
              isSaving = true;
            });
            //TODO meto di salvataggio dati su json
            await Future.delayed(Duration(seconds:3));
            setState(() {
              print("sono qua");
              isSaving = false;
            });
            
            navigateToHomeWithSlideTransition(context);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogEditTrip(
                  onPressed: (bool) {
                    setState(() {
                      isSaving = bool;
                    });
                    if(bool == false) {
                      print("sono qui");
                      navigateToHomeWithSlideTransition(context);
                    }
                  },
                );
              }
            );
          }
        },
        backgroundColor: const Color.fromRGBO(53, 16, 79, 1),
        shape: const CircleBorder(), 
        child: const Icon(Icons.save,color: Colors.white),
      ),
      body: isSaving ? 
        const Center(child: CircularProgressIndicator(),) 
        : selectedIndex == 0 ? 
        ListView.builder(
        itemCount: 1, 
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
      ) : 

      EditTripBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.info),label: "Info"),
          BottomNavigationBarItem(icon: Icon(Icons.add_location_alt),label:  "Location"),
        ],
        currentIndex: selectedIndex,
        onTap: onItemSelected,
      ),
    );

  }
}

class DialogEditTrip extends StatefulWidget {
  const DialogEditTrip({
      Key? key,
      required this.onPressed,
    });

  final Function(bool) onPressed;


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
                  onPressed: () async {
                    widget.onPressed(true);
                    //TODO meto di salvataggio dati su json
                    await Future.delayed(Duration(seconds:3));
                    widget.onPressed(false);
                    //TODO inserire la funzione per salvare i dati e lo spinning
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