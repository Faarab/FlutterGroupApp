//TODO sistemare bug spinning quando salvo le modifiche dal dialogue essro rimane aperto e non visualizzo lo spinning dietro

import 'package:flutter/cupertino.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/widgets/edit_trip_form.dart';

class EditTripBody extends StatefulWidget {
  final TripDTO trip;
  final DateTime startDate;
  final DateTime endDate;
  final Function(String) onChangeName;
  final Function(String) onChangeCityOfDeparture;
  final Function(String) onChangeCityOfArrival;
  final Function(List<DateTime?>) onChangeDate;

  const EditTripBody({
    super.key, 
    required this.trip,
    required this.startDate,
    required this.endDate,
    required this.onChangeName,
    required this.onChangeCityOfDeparture,
    required this.onChangeCityOfArrival,
    required this.onChangeDate,
  });

  @override
  _EditTripBodyState createState() => _EditTripBodyState();
}

class _EditTripBodyState extends State<EditTripBody> {
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
    _startDate = widget.startDate;
    _endDate = widget.endDate;
  }

  @override
  Widget build(BuildContext context) {
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
              widget.onChangeName(_name);
            },
            onChangeCityOfDeparture: (input) {
              setState(() {
                if(input.length > 0) {
                  _cityOfDeparture = input;
                } else {
                  _cityOfDeparture = widget.trip.cityOfDeparture;
                }
              });
              widget.onChangeCityOfDeparture(_cityOfDeparture);
            },
            onChangeCityOfArrival: (input) {
              setState(() {
                if(input.length > 0) {
                  _cityOfArrival = input;
                } else {
                  _cityOfArrival = widget.trip.cityOfArrival;
                }
              });
              widget.onChangeCityOfArrival(_cityOfArrival);
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
              widget.onChangeDate([_startDate, _endDate]);
            },
          )
        ],
      ),
    );
  }
}
