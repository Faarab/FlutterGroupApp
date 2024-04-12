//TODO sistemare bug spinning quando salvo le modifiche dal dialogue essro rimane aperto e non visualizzo lo spinning dietro

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/home_screen.dart';
import 'package:triptaptoe_app/services/modifyTripFromJson.dart';
import 'package:triptaptoe_app/services/navigation.dart';
import 'package:triptaptoe_app/widgets/app_bar_with_back_arrow.dart';
import 'package:triptaptoe_app/widgets/custom_input_field.dart';

import '../widgets/dialog_edit_trip.dart';
import '../widgets/edit_trip_body.dart';
import '../widgets/edit_trip_bottom_navigation_bar.dart';
import '../widgets/edit_trip_floating_action_button.dart';
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
  int _indexOfselectionBody = 0;
  late Widget _body ;


  void changeBody() {
    switch (_indexOfselectionBody) {
      case 0:
        setState(() {
          _body = EditTripBody(
            trip: widget.trip,
            startDate: _startDate,
            endDate: _endDate,
            onChangeName: (value) {
              _name = value;
            },
            onChangeCityOfDeparture: (value) {
              _cityOfDeparture = value;
            },
            onChangeCityOfArrival: (value) {
              _cityOfArrival = value;
            },
            onChangeDate: (value) {
              _startDate = value[0]!;
              _endDate = value[1]!;
            }
          );
        });
        break;
      case 1:
        setState(() {
          //TODO aggiungere edititinerarybody
          _body = const Center(child: Text("Pagina modifica itinerary"),);
        });
        
        break;
      default:
    }
  }
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
      floatingActionButton: _indexOfselectionBody == 0 ? EditTripFloatingActionButton(
        onPressed: () async {
          setState(() {
            isSaving = true;
          });
          //TODO gestire caso di errore
          await modifyTripFromJson(widget.trip.id, _name, _startDate, _endDate, _cityOfDeparture, _cityOfArrival);
          setState(() {
            isSaving = false;
          });
          navigateToHomeWithSlideTransition(context);
        },
      ): EditTripFloatingActionButton(
        onPressed: () {
          //TODO logica per salvataggio di itinerary
        },
      ),
      body: isSaving ? 
        const Center(child: CircularProgressIndicator(),) : 
        _body,
      bottomNavigationBar: EditTripBottomNavigationBar(
  onPressed: (index) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogEditTrip(
                  onPressed: (value) async {                
                    if(value) {
                      setState(() {
                        _indexOfselectionBody = index;
                        changeBody();
                      });
                    }
                  },
                );
              }
            );
        },
      ),
    );
  }
}