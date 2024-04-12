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
  late Widget _body;

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
              });
        });
        break;
      case 1:
        setState(() {
          _name = widget.trip.name;
          _cityOfDeparture = widget.trip.cityOfDeparture;
          _cityOfArrival = widget.trip.cityOfArrival;
          _startDate = widget.trip.startDate;
          _endDate = widget.trip.endDate;
          _body = const Center(
            child: Text("Pagina modifica itinerary"),
          );
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackArrow(),
      floatingActionButton: _indexOfselectionBody == 0
          ? EditTripFloatingActionButton(
              onPressed: () async {
                if (_cityOfArrival != widget.trip.cityOfArrival ||
                    _cityOfDeparture != widget.trip.cityOfDeparture ||
                    _startDate != widget.trip.startDate ||
                    _endDate != widget.trip.endDate) {
                  showDialog(
                      context: context,
                      builder: (BuildContext dContext) {
                        return DialogEditTrip(
                            contentText:
                                "Changing this information will permanently erase all your itinerary information\nDo you want to proceed?",
                            onPressed: (value) async {
                              if (value) {
                                //TODO gestire caso di errore
                                await modifyTripFromJson(
                                    widget.trip.id,
                                    _name,
                                    _startDate,
                                    _endDate,
                                    _cityOfDeparture,
                                    _cityOfArrival);
                                navigateToHomeWithSlideTransition(context);
                              } else {
                                if (mounted) {
                                  Navigator.pop(dContext);
                                }
                              }
                            });
                      });
                } else {
                  setState(() {
                    isSaving = true;
                  });
                  //TODO gestire caso di errore
                  await modifyTripFromJson(widget.trip.id, _name, _startDate,
                      _endDate, _cityOfDeparture, _cityOfArrival);
                  setState(() {
                    isSaving = false;
                  });
                  navigateToHomeWithSlideTransition(context);
                }
              },
            )
          : EditTripFloatingActionButton(
              onPressed: () {
                //TODO logica per salvataggio di itinerary
              },
            ),
      body: isSaving
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(child: _body),
      bottomNavigationBar: EditTripBottomNavigationBar(
        onPressed: (index) {
          if (_indexOfselectionBody == 0 &&
              (_cityOfArrival != widget.trip.cityOfArrival ||
                  _cityOfDeparture != widget.trip.cityOfDeparture ||
                  _startDate != widget.trip.startDate ||
                  _endDate != widget.trip.endDate ||
                  _name != widget.trip.name)) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogEditTrip(
                    contentText:
                        "Changing this section will permanently erase all your changes.\nYou will lose any unsaved information.\nDo you want to proceed?",
                    onPressed: (value) async {
                      if (value) {
                        setState(() {
                          _indexOfselectionBody = index;
                          changeBody();
                        });
                      }
                    },
                  );
                });
          } else {
            setState(() {
              _indexOfselectionBody = index;
              changeBody();
            });
          }
        },
      ),
    );
  }
}
