import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/main.dart';

import '../screens/itinerary_screen.dart';
import 'card_itinerary.dart';
import 'change_day_itinerary.dart';

class BodyItenerary extends StatefulWidget {
  const BodyItenerary({
    super.key,
    required this.widget,
  });

  final ItineraryScreen widget;

  @override
  State<BodyItenerary> createState() => _BodyIteneraryState();
}

class _BodyIteneraryState extends State<BodyItenerary> {
  late int _currentDayIndex;
  late bool _canGoBackward;
  late bool _canGoForward;

  @override
  void initState() {
    super.initState();
    _currentDayIndex = 0;
    _canGoBackward = false;
    if(widget.widget.trip.days!.length > 1) {
      _canGoForward = true;
    }
    else {
      _canGoForward = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("${widget.widget.trip.name} ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          ],
        ), 
        SizedBox(
          height: 0,
        ),
        ChangeDayItinerary(
          widget: widget,
          day: widget.widget.trip.days![_currentDayIndex],
          canGoBackward: _canGoBackward,
          canGoForward: _canGoForward,
          dayIndex: _currentDayIndex,
          onBackward: () {
            setState(() {
              if (_currentDayIndex > 0) {
                _currentDayIndex--;
                _canGoForward = true;
              }
              if (_currentDayIndex == 0) {
                _canGoBackward = false;
              }
            });
          },
          onForward: () {
            setState(() {
              if (_currentDayIndex < widget.widget.trip.days!.length - 1) {
                _currentDayIndex++;
                _canGoBackward = true;
              }
              if (_currentDayIndex == widget.widget.trip.days!.length - 1) {
                _canGoForward = false;
              }
            });
          },
          ),
        SizedBox(
          height: 0,
        ),
        CardItinerary(widget: widget, day: widget.widget.trip.days![_currentDayIndex], ),
      ],
    );
  }
}
