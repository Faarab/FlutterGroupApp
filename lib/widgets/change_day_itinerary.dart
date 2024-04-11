import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/DayDTO.dart';
import 'package:triptaptoe_app/widgets/body_itenerary.dart';

class ChangeDayItinerary extends StatefulWidget {
  const ChangeDayItinerary({
    super.key,
    required this.widget,
    required this.day,
    required this.onBackward,
    required this.onForward,
    required this.canGoForward,
    required this.canGoBackward,
    required this.dayIndex,
  });

  final int dayIndex;
  final DayDTO day;
  final BodyItenerary widget;
  final VoidCallback onBackward;
  final VoidCallback onForward;
  final bool canGoForward;
  final bool canGoBackward;

  @override
  State<ChangeDayItinerary> createState() => _ChangeDayItineraryState();
}

class _ChangeDayItineraryState extends State<ChangeDayItinerary> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: widget.canGoBackward ? widget.onBackward : null, // Imposta null se non è possibile tornare indietro
          icon: Icon(Icons.arrow_back_ios, size: 28),
          color: widget.canGoBackward ? null : Colors.grey.withOpacity(0.5), // Imposta il colore grigio se non è possibile tornare indietro
        ),
        Text("Day ${widget.dayIndex + 1} - ${widget.day.formatDate()}", style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        IconButton(
          onPressed: widget.canGoForward ? widget.onForward : null, // Imposta null se non è possibile andare avanti
          icon: Icon(Icons.arrow_forward_ios, size: 28),
          color: widget.canGoForward ? null : Colors.grey.withOpacity(0.5), // Imposta il colore grigio se non è possibile andare avanti
        ),
      ],
    );
  }
}





