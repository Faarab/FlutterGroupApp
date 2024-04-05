import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/edit_trip_screen.dart';
import 'package:triptaptoe_app/widgets/custom_input_field.dart';

class EditTripForm extends StatefulWidget {
  const EditTripForm({
    super.key,
    required this.trip,
    required this.startDate,
    required this.endDate,
    required this.onChangeName,
    required this.onChangeCityOfDeparture,
    required this.onChangeCityOfArrival,
    required this.onChangeDate,
    });

  final TripDTO trip;
  final DateTime startDate;
  final DateTime endDate;
  final Function(String) onChangeName;
  final Function(String) onChangeCityOfDeparture;
  final Function(String) onChangeCityOfArrival;
  final Function(List<DateTime?>) onChangeDate;
  
  @override
  State<EditTripForm> createState() => _EditTripFormState();
}

class _EditTripFormState extends State<EditTripForm> {

  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate;
    _endDate = widget.endDate;
  }

  @override
  void didUpdateWidget(covariant EditTripForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.startDate != widget.startDate || oldWidget.endDate != widget.endDate) {
      setState(() {
        _startDate = widget.startDate;
        _endDate = widget.endDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomInputField(
            fieldLabel: "Title",
            fieldHintText: widget.trip.name, 
            fieldId: 1, 
            onChanged: widget.onChangeName
          ),
          CustomInputField(
            fieldLabel: "Where from?",
            fieldHintText: widget.trip.cityOfDeparture, 
            fieldId: 2, 
            onChanged: (widget.onChangeCityOfDeparture)
          ),
          CustomInputField(
            fieldLabel: "Where to?",
            fieldHintText: widget.trip.cityOfArrival, 
            fieldId: 3, 
            onChanged: (widget.onChangeCityOfArrival)
          ),
          const SizedBox(
            height:16,
          ),
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
                    "${_startDate.day.toString().padLeft(2, '0')}/${_startDate.month.toString().padLeft(2, '0')}/${_startDate.year}",
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
                    "${_endDate.day.toString().padLeft(2, '0')}/${_endDate.month.toString().padLeft(2, '0')}/${_endDate.year}",
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              )
            ],
          ),
          SizedBox(height:16),
          SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              onPressed: () async {
                var results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(
                    calendarType: CalendarDatePicker2Type.range,
                    firstDate: DateTime.now().isBefore(widget.trip.startDate) ? DateTime.now():widget.trip.startDate,
                    controlsTextStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 16, 79, 1)),
                  ),
                  dialogSize: const Size(325, 400),
                  value: [_startDate, _endDate],
                  borderRadius: BorderRadius.circular(16),
                );
                //If results (dates selected) is not empty, you set startDate and endDate according to the length of the trip
                //If the trip is 1 day long, startDate = endDate, otherwise they're set to the corresponding values
                if (results != null) {
                  widget.onChangeDate(results);
                }
              },
              icon: const Icon(
                Icons.calendar_month_outlined,
                color: Color.fromRGBO(53, 16, 79, 1),
              ),
              label: const Text("Change trip dates"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                side: const BorderSide(
                    color: Color.fromRGBO(53, 16, 79, 1), width: 2),
                foregroundColor: const Color.fromRGBO(53, 16, 79, 1),
              )),
          )
        ]
      ),
    ); 
  }
}
