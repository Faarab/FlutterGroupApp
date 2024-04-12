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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentDayIndex = 0;
    _canGoBackward = false;
    if (widget.widget.trip.days!.length > 1) {
      _canGoForward = true;
    } else {
      _canGoForward = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        
        const SizedBox(
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
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
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
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              }
              if (_currentDayIndex == widget.widget.trip.days!.length - 1) {
                _canGoForward = false;
              }
            });
          },
        ),
        const SizedBox(
          height: 0,
        ),
        CardItinerary(
          widget: widget,
          day: widget.widget.trip.days![_currentDayIndex],
          scrollController: _scrollController,
        ),
      ],
    );
  }
}
